BB = require 'badass-backbone'


class exports.TagView extends BB.BadassView
  logging: on
  tmpl: require './templates/tag'
  render: ->
    @$el.html @tmpl @model.toJSON()
    @


class exports.TagsView extends BB.BadassView
  el: '#tags'
  render: ->
    $log 'el', @$el
    @$el.append(new exports.TagView(model:t).render().el) for t in @collection.models


module.exports = exports