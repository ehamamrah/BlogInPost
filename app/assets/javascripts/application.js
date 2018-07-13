// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets
//= require growlyflash
//= require_tree .

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})

// Changeable text on homepage
$(function($){
    var roles = ['Power your knowledge', 'Read more from people around you', 'Enjoy sharing your experience with others'];
    //used to determine which is the next roles to be displayed
    var counter = 0;
    //repeat the passed function at the specified interval - it is in milliseconds
    setInterval(function(){
        //display the role and increment the counter to point to next role
        $('#changeable-text').fadeIn(2000).text(roles[counter++]);
        //if it is the last role in the array point back to the first item
        if(counter >= roles.length){
            counter = 0;
        }
    }, 3500)
})
