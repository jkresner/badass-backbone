BB = require 'badass-backbone'
M = require './models'
C = require './collections'
exports = {}

class exports.DJView extends BB.BadassView
  el: '#dj'

  initialize: (dj) ->
    @listenTo @model, 'change', @render

  render: ->
    m = @model.toJSON()
    @$el.html "<h1>#{m.name}</h1>"
    @

class exports.DJRowView extends BB.BadassView
  tagName: 'li'

  render: ->
    m = @model.toJSON()
    @$el.html "<a href='#dj/#{m.id}'>#{m.name}</a>"
    @

class exports.DJsView extends BB.BadassView
  el: '#djs'
  initialize: (args) ->
    @listenTo @collection, 'reset', @render

  render: ->
    for m in @collection.models
      @$el.append( new exports.DJRowView( model: m ).render().el )
    @

module.exports = exports
