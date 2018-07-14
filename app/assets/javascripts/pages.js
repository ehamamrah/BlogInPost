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

// Change Jumbotron color
$(function($){
    var colors = ['#6c5ce7','#FF6B6B', '#00b894', '#4ECDC4', '#e17055', '#1A535C'];
    //used to determine which is the next roles to be displayed
    var counter = 0;
    //repeat the passed function at the specified interval - it is in milliseconds
    setInterval(function(){
        //display the role and increment the counter to point to next role
        $('#custom-jumbotron').css("background-color", colors[counter++]);
        //if it is the last role in the array point back to the first item
        if(counter >= colors.length){
            counter = 0;
        }
    }, 3500)
})
