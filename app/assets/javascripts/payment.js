$(document).ready(function(){

var stripeScript = '';

  $('#entered_amount').on('change', function(event){
    var cents = Number($(this).val());
    $('#stripe_script').attr('data-amount', cents);
  });
})