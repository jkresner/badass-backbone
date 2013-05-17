BB = require 'badass-backbone'
M = require './models'
C = require './collections'
V = require './views'


module.exports = class Router extends BB.BadassAppRouter

  logging: on

  pushStateRoot: '/demos/spa.html'

  routes:
    'step1'       : 'step1'
    'step2'       : 'step2'
    'step3'       : 'step3'

  appConstructor: (pageData, callback) ->
    d = {}
#      company: new M.Company _id: 'me'
    v = {}
 #     welcomeView: new V.WelcomeView()

    _.extend d, v

  initialize: (args) ->
    @navTo 'step1'

  #step1: ->
    # can even not define the function and you'll get a default one for free

  step2: ->
    # can even have an empty declaration

  step3: ->
    $log 'do something custom here'

