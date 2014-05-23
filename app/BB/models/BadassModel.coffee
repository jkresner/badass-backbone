""" BadassModel add 2 basic bits of functionality to a normal Backbone.Model
    1) Auto-logging of events to
    2) Short hand to extend the json object of the model
"""
module.exports = class BadassModel extends Backbone.Model

  # Set logging on /off - during dev to see events fire on model
  logging: off

  # You should override the idAttribute to match you back-end
  # _id = mongodb ids
  idAttribute:  '_id'

  constructor: (args) ->

    if @logging
      $log 'BadassMode.ctor', args
      @enableLogging()

    Backbone.Model::constructor.apply @, arguments

  # Useful when building data request for templates that combines data
  # in the attributes of the model plus computed data from another source
  # i.e.
  #   templateData = _.extend @model.toJSON(), { moreData: 1234 }
  # vs
  #   templateData = @model.extendJSON { moreData: 1234 }
  extendJSON: (args) ->
    _.extend @toJSON(), args

  extend: (args) -> @extendJSON args

  silentReset: (args) ->
    @clear silent: true
    @set args, { silent: true }

  enableLogging: ->

    # Get type name of the model to distinguish it in log statements
    @modelTypeName = @constructor.name

    @listenTo @, 'change', (e) => $log("#{@modelTypeName}.change", e)
    @listenTo @, 'request', (e) => $log("#{@modelTypeName}.request", e)
    @listenTo @, 'invalid', (e) => $log("#{@modelTypeName}.invalid", e)
    @listenTo @, 'error', (e) => $log("#{@modelTypeName}.error", e)

  # checkfor500: (model, errors, options) ->
  #   if errors? & errors.code is 500
  #     exports.render500 errors, 'Failed to get data: ' + model.url

  validateNonEmptyArray: (value, attr, computedState) ->
    # console.log 'validateNonEmptyArray', value, attr, computedState
    if !value? || value.length is 0 then true
