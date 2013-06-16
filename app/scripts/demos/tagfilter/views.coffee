BB = require 'badass-backbone'


class exports.TagView extends BB.BadassView
  logging: on
  tmpl: require './templates/tag'
  render: -> 
    @$el.html @tmpl @model.toJSON()
    @


class exports.TagsView extends BB.BadassView
  el: '#tag-filter'
  events: 
  	'keypress :input': 'filter'
  initialize: ->
  	@input = @$("#tag-filter");
  	@models= {}
  render: ->
    @$el.find("#tags").html(new exports.TagView(model:t).render().el) for t in @models

  filter:(e) ->
    return if (e.keyCode != 13) 
    return if (!@input.val())
    tag = @input.val()
    @models = @collection.where(name: tag)
    @render()


module.exports = exports