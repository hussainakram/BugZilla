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

$ ->
  $('.feature_status').hide()
  $('.bug_status').hide()
  $('.bug_types').change ->
    bug_types = $('.bug_types :selected').text()
    if bug_types == 'Bug'
      $('.feature_status').hide()
      $('.bug_status').show()
    else if bug_types == 'Feature'
      $('.bug_status').hide()
      $('.feature_status').show()

$ ->
  $('#bug_audits').hide()
  $('.bug_audits_btn').click ->
    $('#bug_audits').show()
  $('.hide_bug_audits_btn').click ->
    $('#bug_audits').hide()
