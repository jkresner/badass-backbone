BB = './../lib/badassbackbone'


class exports.TeaView extends Backbone.View
  logging: on       # turn on / off to get console output
  tagNane: 'tr'
  className: 'jsDeveloper'
  events:
    'click a': 'save'
  render: ->
    @$el.html "<td><input type='text' val='#{}' /></td><td><input type='text' val='#{}' /></td><td><a href='#'>Save</a></td>"
    @
  save: ->
    @$el.addClass 'saved'


class exports.TeasView extends Backbone.View
  logging: on       # turn on / off to get console output
  el: '#teas'
  initialize: (args) ->
    @collection.on 'reset', @render, @
  render: ->
    for m in @collection.models
      @$el.append( new exports.TeaView( model: m ).render().el )
    @