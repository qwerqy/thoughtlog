$(document).on('turbolinks:load', function() {
  $('.change-email-window').hide();
  $('#change-email').one('click', (e) => {
    e.preventDefault();
    $('.change-email-window').show();
  })
})
