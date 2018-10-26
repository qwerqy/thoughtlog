$(document).on('turbolinks:load', function() {
    $('.image img')
      .visibility({
        type       : 'image',
        transition : 'fade in',
        duration   : 1000
      })
    ;
})
