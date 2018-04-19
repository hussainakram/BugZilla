# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#bug_statuses').hide()
  $('#feature_statuses').hide()
  $('#bug_type').change ->
    bug_type = $('#bug_type :selected').text()
    if bug_type == 'Bug'
      $('#feature_statuses').hide()
      $('#bug_statuses').show()
    else if bug_type == 'Feature'
      $('#bug_statuses').hide()
      $('#feature_statuses').show()
  $('#bug_status').hide()
  $('#feature_status').hide()
  $('#bug_type').change ->
    bug_type = $('#bug_type :selected').text()
    if bug_type == 'Bug'
      $('#feature_status').hide()
      $('#bug_status').show()
    else if bug_type == 'Feature'
      $('#bug_status').hide()
      $('#feature_status').show()
