BB = require 'badass-backbone'
C = require './collections'
M = require './models'
D = require './../../stubs/tags'
V = require './views'

# Inherit from BadassAppRouter to get Badass Backbone conventions
module.exports = class Router extends BB.BadassAppRouter

  logging: on

  # routes:
  #   '' : ''

  appConstructor: (pageData, callback) ->

    d = # d is shorthand for 'data', i.e. models & collections
      tags: new C.Tags D
      #employee: new M.Employee()

    v = # v is shorthand for views
      tagsView: new V.TagsView collection: d.tags

    _.extend d, v


  initialize: ->
    @app.tagsView.render()