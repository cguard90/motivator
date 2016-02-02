$(document).ready(function (){

  $('.milestone-btn').on('click', function(event){
    event.preventDefault();
    var snippet = $('.milestone-partial:last').clone();
    var last = $('.mstone:last').attr('name').substring('mstone_d'.length);

    snippet.find('input').each(function(index, element){
      var name = $(element).attr('name');
      var newName = name.replace(last, Number(last)+1);
      $(element).attr('name', newName);
    })

    $('.milestone-form').append(snippet);
    $('#milestone_count').val(Number(last)+1);

  });
});
