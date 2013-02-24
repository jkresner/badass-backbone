BB = require './../../lib/badassbackbone'


class exports.TeaView extends BB.BadassView
  logging: on       # turn on / off to get console output
  tagNane: 'tr'
  className: 'jsDeveloper'
  events:
    'click a': 'save'
  render: ->
    m = @model.toJSON()
    @$el.html "<td><input type='text' value='#{m.name}' /></td><td><input type='text' value='#{m.origin}' /></td><td><a href='#'>Save</a></td>"
    @
  save: ->
    @$el.addClass 'saved'


class exports.TeasView extends BB.BadassView
  logging: on       # turn on / off to get console output
  el: '#teas'
  initialize: (args) ->
    @collection.on 'reset', @render, @
  render: ->
    for m in @collection.models
      @$el.append( new exports.TeaView( model: m ).render().el )
    @