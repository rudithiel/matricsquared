# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  
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