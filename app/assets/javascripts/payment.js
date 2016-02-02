$(document).ready(function(){
  // $("input#entered_amount").val()

  $("#charges").on("click", function(event){
    event.preventDefault();
    $.ajax({
      type: "GET",
      url: "/charges/new",
      data: $(this).serialize
    }).done(function(response){
      $("#new_support").append(response);
    });
  });
})