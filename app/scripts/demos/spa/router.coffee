BB = require 'badass-backbone'
M = require './models'
V = require './views'

# Inherit from BadassAppRouter to get Badass Backbone conventions
module.exports = class Router extends BB.BadassAppRouter

  logging: on

  pushState: off  # Set off for simple example

  routes:
    ''            : 'step1'   ## set empty route for default route handler
    'step1'       : 'step1'
    'step2'       : 'step2'
    'step3'       : 'step3'

  # Construct all models, collections & views for SPA. They get assigned
  # onto window.router.app (in BadassAppRouter constructor). Having
  # them globally accessible means easy testing / stubbing of all objects
  appConstructor: (pageData, callback) ->

    d = # d is shorthand for 'data', i.e. models & collections
      company: new M.Company()
      employee: new M.Employee()

    v = # v is shorthand for views
      step1View: new V.Step1View el: '#step1', model: d.company
      step2View: new V.Step2View el: '#step2', model: d.employee
      step3View: new V.Step3View el: '#step3'

    _.extend d, v

  # BadassAppRouter automatically warps the step1 route handler.
  # You'll see a "Router.Step1" log before you hit the log inside step1
  step1: -> $log 'do something custom here inside step1'

  # The route handler can have nothing in it and you'll
  # still see router moving the UI to the step2 content
  step2: ->

  # You can even be LAZY & not define the route handler at all
  # step3: ->