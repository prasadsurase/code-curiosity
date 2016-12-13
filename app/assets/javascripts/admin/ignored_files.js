$(document).on('page:change', function(event) {

  $(function() {
    $('#file').bootstrapToggle();
  })
  
  $('#file').change(function() {
    query = $('#q').val();    
    $.ajax({
        type: 'get',
        url: '/admin/ignored_files', 
        data: {'ignored': !($(this).is(':checked')), query: query}
    })
  })
});