# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  
  $('.counter').counterUp time: 1500
  
  $('#learn-more-button').click ->
    $('html, body').animate { scrollTop: $('#how-it-works').offset().top }, 200
    return
  

