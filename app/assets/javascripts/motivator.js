$(document).ready(function (){

  $('.button_to').on('click', function(event){
    event.preventDefault();
    $.ajax({
      url:$(this).attr("action"),
    }).done(function(response){
      $('#milestone-partial').append(response)
    });
  })

  $(".button_submit").on("click", function(e){
    e.preventDefault()
    debugger
  $("#milestone-partial").trigger("submit")
  $(".new_goal").trigger("submit");
  debuuger
  });
});
