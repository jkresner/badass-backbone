module.exports = class BadassModel extends Backbone.Model

  idAttribute:  '_id'     # mongo ids

  constructor: (args) ->
    Backbone.Model::constructor.apply @, arguments
    #@on 'error', @checkfor500, @

  validateNonEmptyArray: (value, attr, computedState) ->
    # console.log 'validateNonEmptyArray', value, attr, computedState
    if !value? || value.length is 0 then true

  # very useful for calculating extra values needed for templates
  extend: (args) ->
    _.extend @toJSON(), args
