# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  #Submit form when clicking on checkbox
  $("input[name='circle[revised]']").change ->
    $(this).closest("form").submit()

  #Check multiple checkboxes using the select key
  $.fn.shiftSelectable = ->
    lastChecked = undefined
    $boxes = this
    $boxes.click (evt) ->
      unless lastChecked
        lastChecked = this
      if evt.shiftKey
        start = $boxes.index(this)
        end = $boxes.index(lastChecked)
        $boxes.slice(Math.min(start, end), Math.max(start, end) + 1).prop("checked", lastChecked.checked).trigger "change"
      lastChecked = this

  $('form').find('input[type="checkbox"]').shiftSelectable();

$(document).ready(ready)
$(document).on('page:load', ready)