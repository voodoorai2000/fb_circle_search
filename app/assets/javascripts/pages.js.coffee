# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# The ready state

ready = ->
  console.log 'ready'

# JS to check whether a circle has been visited
$(document).on 'click', '.js-circle-visited', (e)->
  $(@)
  .closest('tr')
  .find('td:not(:last-child)')
  .toggleClass 'status-visited'

$(document).ready(ready)
  