BB = './../lib/badassbackbone'
tmpl_jsDevRow = require './templates/jsDevRow'
tmpl_devRow = require './templates/devRow'


class exports.JSDeveloperView extends Backbone.View
  className: 'jsDeveloper'
  render: ->
    @$el.html tmpl_jsDevRow( @model.toJSON() )
    @


class exports.JSDevelopersView extends Backbone.View
  logging: on
  el: '#jsDevelopers'
  initialize: (args) ->
    @collection.on 'reset filter sort', @render, @
  render: ->
    for m in @collection.models
      @$el.append( new exports.JSDeveloperView( model: m ).render().el )
    @