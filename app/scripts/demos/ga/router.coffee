BB = require 'badass-backbone'
M = require './models'
C = require './collections'
V = require './views'
ExternalProviders = require './externalproviders'

module.exports = class Router extends BB.BadassAppRouter

  logging: on
  enableExternalProviders: true

  pushStateRoot: '/demos/ga.html'

  routes:
    ''              : 'djs'
    'djs'           : 'djs'
    'dj/:id'        : 'dj'

  appConstructor: (pageData, callback) ->
    d =
      djs: new Backbone.Collection()
      selected: new Backbone.Model()
    v =
      djsView: new V.DJsView collection: d.djs
      djView: new V.DJView model: d.selected

    @resetOrFetch d.djs, pageData.djs

    _.extend d, v

  initialize: (args) ->

  dj: (id) ->
    result = @app.djs.get id
    @app.selected.set result.attributes

  loadExternalProviders: ->
    ExternalProviders.initialiseGA()

  routeMiddleware: (routeFn) ->
    ExternalProviders.trackRouteWithGA routeFn

