$(document).ready(function(){
   
    // Revealing signup form
    $("#signup-link").click(function(e) {
        e.preventDefault();
        $("#signup").removeClass('hidden');
    });
    // Hiding signup form
    $("#submit-signup").click(function(e) {
        console.log("test")
        $("#signup").addClass('hidden');
    });
     // Revealing login form
     $("#login-link").click(function(e) {
        e.preventDefault();
        $("#login").removeClass('hidden');
    });
    // Hiding login form
    $("#submit-login").click(function(e) {
        console.log("test")
        $("#login").addClass('hidden');
    });
    $('.datepicker').datepicker();
});