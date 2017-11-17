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
    question_id = $('#question-id').html()          #Get variables from hidden HTML elements
    user_answer = $('input[type="radio"][name="options"]:checked').val()
    
    $.ajax "/question/" + question_id + "/details",
            type: "GET"
            datatype: "json"
            error: (jqXHR, textStatus, errorThrown) ->
              alert "Error reaching server. Please try again"
            success: (data, textStatus, jqXHR) ->
              question_answer = data.answer

              if (typeof user_answer == 'undefined')
                alert "Select an answer first"
              else
                #SEXY AJAX MAGIC
                $.ajax "/question/" + question_id + "/answer/" + user_answer,
                      type: "POST"
                      datatype: "json"
                      error: (jqXHR, textStatus, errorThrown) ->
                            console.log "Error submitting answer"
                            console.log jqXHR
                            console.log textStatus
                      success: (data, textStatus, jqXHR) ->
                            console.log "Answer submitted to controller"
                #Change classes of input
                $('.question-answer-radio').addClass("disabled")
                $('#question-option-label-' + question_answer).addClass("btn-success")
                $('#question-option-label-' + question_answer).removeClass("btn-outline-warning")
                $('#question-answer-submit').addClass("disabled")
                $("#question-answer-submit").prop("disabled", "disabled")
                $('#question-results').show()
                if user_answer == question_answer
                  $('#question-result-alert').addClass("alert alert-success")
                  $('#question-result-header').html("Well done!")
                  $('#question-result-feedback').html("You answered correctly")
                else
                  $('#question-option-label-' + user_answer).removeClass("btn-outline-warning")
                  $('#question-option-label-' + user_answer).addClass("btn-danger")
                  $('#question-result-alert').addClass("alert alert-danger")
                  $('#question-result-header').html("Oops!")
                  $('#question-result-feedback').html("The correct answer is " + question_answer)
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

  
controlInput = (input, textarea_id) ->
  cursorPosition = $('#' + textarea_id).prop('selectionStart')
  currentText = $('#' + textarea_id).val()
  newText = currentText.substr(0,cursorPosition) + input + currentText.substr(cursorPosition, currentText.length)
  $('#' + textarea_id).val(newText)
  $('#textarea-preview').html("")
  $('#textarea-preview').append($('#' + textarea_id).val())
  $('#' + textarea_id).focus()
  return