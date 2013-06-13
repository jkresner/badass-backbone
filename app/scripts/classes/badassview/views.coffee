BB = require 'badass-backbone'


class exports.TeaView extends BB.BadassView
  logging: on       # turn on / off to get console output
  tagName: 'tr'
  events:
    'click a': 'save'
  render: ->
    m = @model.toJSON()
    @$el.html "<td><input type='text' value='#{m.name}' name='name' /></td><td><input type='text' value='#{m.origin}' name='origin' /></td><td><a href='#' class='btn'>Save</a></td>"
    @
  save: ->
    $log 'You saved', @elm('name').val(), @elm('origin').val()
    @$('.btn').hide()
    @$el.addClass 'saved'


class exports.TeasView extends BB.BadassView
  logging: on       # turn on / off to get console output
  el: '#teas'
  initialize: (args) ->
    @listenTo @collection, 'reset', @render
  render: ->
    $log 'cmo', @collection.models
    for m in @collection.models
      @$el.append( new exports.TeaView( model: m ).render().el )
    @


module.exports = exports
