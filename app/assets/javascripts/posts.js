var elements = ['#title', '#description', '#content', '#submit'];

$(document).on('mouseenter', function(){
  var pickedElement = 0;
  for(pickedElement; pickedElement <= elements.length; pickedElement++){
    window_is_refreshed() ? $(elements[pickedElement]).hide() : $(elements[pickedElement]).show();
  };
});

$(document).on('keydown', 'input', function(){
  nextElement();
});

$(document).on('change', '#selected', function(){
  $(elements[0]).show();
});

function nextElement(){
  var i = 0;
  for(i; i <= elements.length; i++) {
    goNext(i);
  }
}

function goNext(i){
  $(elements[i]).on('keydown', function(){
    $(elements[i + 1]).show();
  })
}

function window_is_refreshed(){
  return $(document).context.location.href == $(document).context.location.origin + '/posts/new'
}
