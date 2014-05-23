BadassView = require './BadassView'


""" A view that is capable of rendering
    1) An error summary state
    2) Single field/input level errors
    3) Delegate to a 500 state """
module.exports = class HasErrorStateView extends BadassView

  showSummaryOnClientError: false

  constructor: (args) ->

    BadassView::constructor.apply @, arguments

  ###
  expects errors from the server to look like
    {
      data: {
        fieldName: message
      }
    }
  ###
  renderError: (model, resp, opts) =>

    if @logging then $log 'renderError', model, resp, opts

    try
      errors = JSON.parse(resp.responseText)

    if errors?

      if errors.code is 500 then return @delegate500Error()

      if @logging then $log 'errors', errors.isServer, errors

      # (1) Unless showAlertOnClientError=true we only use summary for server errors
      if errors.isServer? || @showAlertOnClientError
        @renderErrorSummary model, errors

      # (2) For both client & server we show field / input level errors
      for own attr, value of errors.data
        if @logging then $log 'attr', attr, value #, input, input.val()

        @tryRenderInputInvalid attr, value

  delegate500Error: ->

    $log 'HasErrorStateView.delegate500 not implemented'

  tryRenderInputInvalid: (attr, msg) ->
    input = @elm attr

    if input.length
      @renderInputInvalid input, msg
    else
      $log "WARN: input not found for #{attr}. ERROR: #{JSON.stringify(msg)}"


  renderInputsValid: -> $log 'Subclass & renderInputsValid'
  renderErrorSummary: -> $log 'Subclass & renderErrorSummary'
