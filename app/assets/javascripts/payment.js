$(document).ready(function(){

  $(".button_to").on("submit", function(event) {
    event.preventDefault();
    $.ajax({
      type: "GET",
      url: $(event.target).attr("action"),
      data: $(this).serialize
    }).done(function(response){
      $(".button_to").toggle();
      $(".support-button").append(response);
    });
  });
})