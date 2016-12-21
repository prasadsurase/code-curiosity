$(document).on('page:change', function(event) {

  $(".shorten_read").shorten({
    showChars: 100,
    moreText: 'show more',
    lessText: 'show less'
  });

  $('#rescoreModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget); // Button that triggered the modal
    var modal = $(this);
    modal.find('form').attr('action', '/activities/' + button.data('id') + '/rescore');
    modal.find('form #resource_type').val(button.data('type'));
    modal.find('form #comment').val('');
    modal.find('.modal-title').text('Rescore ' + button.data('type'));
  });

  $('button').tooltip();

});
