# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  
  $(document).keydown (e) ->
    e.stopImmediatePropagation()
    if e.which == 50 && e.ctrlKey
      e.preventDefault()
      controlInput("<sup>2</sup>")
    if e.which == 51 && e.ctrlKey
      e.preventDefault()
      controlInput("<sup>3</sup>")
    if e.which == 50 && e.altKey
      e.preventDefault()
      controlInput("<sub>2</sub>")
    if e.which == 51 && e.altKey
      e.preventDefault()
      controlInput("<sub>3</sub>")
  
  $("question-text").focus()  
  
  textarea_id = 'question-text'
  
  $('.control-btn').click (e) ->
    e.stopImmediatePropagation()
    controlInput($(this).attr('id'))
    
  $('#fraction-control-btn').click (e) ->
    e.stopImmediatePropagation()
    cursorPosition = $('#' + textarea_id).prop('selectionStart')
    currentText = $('#' + textarea_id).val()
    newText = currentText.substr(0,cursorPosition) + "&frasl;" + currentText.substr(cursorPosition, currentText.length)
    $('#' + textarea_id).val(newText)
    $('#textarea-preview').html("")
    $('#textarea-preview').append($('#' + textarea_id).val())
    $('#' + textarea_id).focus()

  controlInput = (input) ->
    cursorPosition = $('#' + textarea_id).prop('selectionStart')
    currentText = $('#' + textarea_id).val()
    newText = currentText.substr(0,cursorPosition) + input + currentText.substr(cursorPosition, currentText.length)
    $('#' + textarea_id).val(newText)
    $('#textarea-preview').html("")
    $('#textarea-preview').append($('#' + textarea_id).val())
    $('#' + textarea_id).focus()
  
  $('.question-textarea').click (e) ->
    e.stopImmediatePropagation()
    $('#textarea-preview').html("")
    $('#textarea-preview').append($(this).val())
    textarea_id = $(this).attr('id')
    return
    
  $('.question-textarea').bind 'input' , (e) ->
    textarea_id = $(this).attr('id')
    $('#textarea-preview').html("")
    $('#textarea-preview').append($('#' + textarea_id).val()) 
    return
    
  
  $('#question-answer-submit').click ->
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
  return


    
$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('turbolinks:load', ready)