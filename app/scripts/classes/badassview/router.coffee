BB = require 'badass-backbone'
M = require './models'
C = require './collections'
V = require './views'

module.exports = class Router extends BB.BadassAppRouter

  pushState: off

  appConstructor: (pageData, callback) ->
    d =
      teas: new C.Teas()
    v =
      teasView: new V.TeasView collection: d.teas

    d.teas.reset pageData.teas

    _.extend d, v