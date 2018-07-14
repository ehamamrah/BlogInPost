#!/bin/bash

set -e # Exit on errors

if [ -n "$TMUX" ]; then
  export NESTED_TMUX=1
  export TMUX=''
fi

if [ ! $DRAPER_LOCATION ]; then export DRAPER_LOCATION=$HOME/workspace/BlogInPost; fi

cd $DRAPER_LOCATION

tmux new-session  -d -s draper
tmux set-environment -t draper -g DRAPER_LOCATION $DRAPER_LOCATION

tmux new-window     -t draper -n 'Web'
tmux send-key       -t draper 'cd $DRAPER_LOCATION'      Enter 'rails s'                                           Enter

tmux new-window     -t draper -n 'Console'
tmux send-key       -t draper 'cd $DRAPER_LOCATION'      Enter 'rails c'                                           Enter

tmux new-window     -t draper -n 'Vim'
tmux send-key       -t draper 'cd $DRAPER_LOCATION'      Enter 'vim .'                                           Enter

if [ -z "$NESTED_TMUX" ]; then
  tmux -2 attach-session -t draper
else
  tmux -2 switch-client -t draper
fi
