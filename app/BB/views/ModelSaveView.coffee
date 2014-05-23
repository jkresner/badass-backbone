HasBootstrapErrorStateView = require './HasBootstrapErrorStateView'

"""
JK(03.16.13) TODO figure out how to decouple inheritance chain to use other
ErrorStateVies besides the bootstrap one
"""

# A view that   (1) knows how to save a model & hook in Backbone.Validation
#               (2) knows how to get data from the view for saving the model via 'viewdata()'
#               (3) is capable of rendering an success state
#               (4) put the view back into default state if the user tries to save without changes to the model
module.exports = class ModelSaveView extends HasBootstrapErrorStateView

  # change this guy in the class definition to use a different
  # error rendering mechanism
  #ErrorStateViewType:

  async: on

  constructor: (args) ->
    HasBootstrapErrorStateView::constructor.apply @, arguments

  initialize: ->
    throw Error 'must inherit ModelSaveView & implement initialize'

  save: (e) ->
    if e? then e.preventDefault()

    newattrs = @getViewData()

    Backbone.Validation.unbind @
    Backbone.Validation.bind @

    if @logging
      $log 'ModelSaveView.save', 'old:',@model.toJSON(), 'new:',newattrs, 'changes:', @model.changedAttributes newattrs

    # Remove any existing error state before we try save again
    @renderInputsValid()

    options = success: @renderSuccess, error: @renderError, wait: !@async
    @model.save newattrs, options

    false

  # By default renderSuccess looks for a bootstrap alert-success element
  # override in inheriting classes for custom behavior
  renderSuccess: (model, response, options) =>

    if @logging
      $log 'ModelSaveView.renderSuccess', @, model, response, options

    if @$('.alert-success').length > 0
      @$('.alert-success').fadeIn(800).fadeOut(5000)


  # override getViewData in child if you want to do something custom
  getViewData: ->
    @getValsFromInputs @viewData

  # assumes name (NOT ID!) of an input matches the name of an attribute & grabs the vals associated w specified atrrs
  getValsFromInputs: (attrs) ->
    obj = {}
    obj[attr] = @$("[name='#{attr}']").val() for attr in attrs
    obj

# assumes name (NOT ID!) of an input matches the name of an attribute & grabs the vals associated w specified atrrs
  setValsFromModel: (attrs) ->
    @$("[name='#{attr}']").val( @model.get attr ) for attr in attrs
