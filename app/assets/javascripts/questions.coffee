# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  textarea_id = "question-text"
  
  $('.control-btn').click (e) ->
    e.stopImmediatePropagation()
    controlInput($(this).attr('id'), textarea_id)
    return
    
  $('#fraction-control-btn').click (e) ->
    e.stopImmediatePropagation()
    cursorPosition = $('#' + textarea_id).prop('selectionStart')
    currentText = $('#' + textarea_id).val()
    newText = currentText.substr(0,cursorPosition) + "&frasl;" + currentText.substr(cursorPosition, currentText.length)
    $('#' + textarea_id).val(newText)
    $('#textarea-preview').html("")
    $('#textarea-preview').append($('#' + textarea_id).val())
    $('#' + textarea_id).focus()
    return
  
  $('.question-textarea').click (e) ->
    console.log "text area clicked: " + $(this).attr('id')
    textarea_id = $(this).attr('id')
    e.stopImmediatePropagation()
    $('#textarea-preview').html("")
    $('#textarea-preview').append($(this).val())
    return
    
  $('.question-textarea').bind 'input' , (e) ->
    e.stopImmediatePropagation()
    textarea_id = $(this).attr('id')
    $('#textarea-preview').html("")
    $('#textarea-preview').append($('#' + textarea_id).val()) 
    return
    
  fired = false
    
  $(document).keydown (e) ->
    if e.which == 50 && e.ctrlKey && fired == false
      fired = true
      controlInput("<sup>2</sup>", textarea_id)
    if e.which == 51 && e.ctrlKey && fired == false
      fired = true
      controlInput("<sup>3</sup>", textarea_id)
    if e.which == 50 && e.altKey && fired == false
      fired = true
      controlInput("<sub>2</sub>", textarea_id)
    if e.which == 51 && e.altKey && fired == false
      fired = true
      controlInput("<sub>3</sub>", textarea_id)
  
  $(document).keyup (e) ->
    fired = false
    
  $('#question-answer-submit').click (e) ->
    e.stopImmediatePropagation()
    questionAnswer = $('#question-answer').html()
    userAnswer = $('input[type="radio"][name="options"]:checked').val()
    
    if (typeof userAnswer == 'undefined')
      alert "Select an answer first"
    else
      $('#question-answer-submit').addClass("disabled")
      $("#question-answer-submit").prop("disabled", "disabled")
      $('#question-results').show()
      if userAnswer == questionAnswer
        $('#question-result-alert').addClass("alert alert-success")
        $('#question-result-header').html("Well done!")
        $('#question-result-feedback').html("You answered correctly")
      else
        $('#question-result-alert').addClass("alert alert-danger")
        $('#question-result-header').html("Oops!")
        $('#question-result-feedback').html("The correct answer is " + questionAnswer)
    return
    
  $('#star-question-icon').on 'click', (e) ->
    if $(this).hasClass "fa-star"
      $(this).removeClass('fa-star')
      $(this).addClass('fa-star-o')
    else if $(this).hasClass "fa-star-o"
      $(this).removeClass('fa-star-o')
      $(this).addClass('fa-star')
    return

    
  return


    
###$(document).ready(ready)
$(document).on('page:load', ready)###
  
controlInput = (input, textarea_id) ->
  cursorPosition = $('#' + textarea_id).prop('selectionStart')
  currentText = $('#' + textarea_id).val()
  newText = currentText.substr(0,cursorPosition) + input + currentText.substr(cursorPosition, currentText.length)
  $('#' + textarea_id).val(newText)
  $('#textarea-preview').html("")
  $('#textarea-preview').append($('#' + textarea_id).val())
  $('#' + textarea_id).focus()
  return