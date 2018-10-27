$(document).on('turbolinks:load', function() {
  $('.change-email-window').hide();
  $('.change-password-window').hide();

  $('#change-email').one('click', (e) => {
    e.preventDefault();
    $('.change-email-window').show();
  })

  $('#change-password').one('click', (e) => {
    e.preventDefault();
    $('.change-password-window').show();
  })
})
