# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('#paper-2-categories').hide()
  $('#paper-2-practice').hide()
  $('#test-paper-2').hide()
  
  $('#paper-1-toggle').click (e) ->
    e.stopImmediatePropagation()
    $('#test-paper-2').hide()
    $('#test-paper-1').show()
    $('#paper-1-categories').show()
    $('#paper-2-categories').hide()
    $('#paper-2-toggle').removeClass("active")
    $('#paper-1-toggle').addClass("active")
    $('#paper-1-practice').show()
    $('#paper-2-practice').hide()
    
  $('#paper-2-toggle').click (e) ->
    e.stopImmediatePropagation()
    $('#test-paper-1').hide()
    $('#test-paper-2').show()
    $('#paper-2-categories').show()
    $('#paper-1-categories').hide()
    $('#paper-1-toggle').removeClass("active")
    $('#paper-2-toggle').addClass("active")
    $('#paper-2-practice').show()
    $('#paper-1-practice').hide()
  
$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('turbolinks:load', ready)