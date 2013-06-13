exports = {}

###############################################################################
## Private helper functions
###############################################################################


# inject html below our mocha test runner to execute a test with html context
setHtmlfixture = (html) ->
  $('body').append('<div id="fixture">'+html+'</div>')

clearHtmlfixture = ->
  $('#fixture').remove()


###############################################################################
## Exported helper functions
###############################################################################


# """ showsError: short hand for checking a bootstrap validation error """
# exports.showsError = (input) ->
#   controls = input.parent()
#   # $log 'controls', controls
#   $(controls).find('.error-message').length > 0


""" setInitApp
allows us to redefine initApp() from one test to another
since normally in a badass-backbone app it would be defined on the html
page and we can't do that from a mocha test harness page """
exports.setInitApp = (routerPath, sessionUser) ->

  sessionUser = { authenticated: false } if !sessionUser?

  window.initApp = (pageData) =>
    # $log 'initApp', routerPath, pageData

    pageData = {} if !pageData?

    Router = require routerPath

    # turn pushState off so browser doesn't navigate away from mocha test page
    Router::pushState = off

    # stop router loading google analytics & other external scripts
    Router::enableExternalProviders = off

    # if we are running test for many routers we make sure the don't clash
    if window.router? then Backbone.history.stop()

    # set our global router object as normal in badass-backbone convention
    window.router = new Router pageData

""" cleanSetup
called in conjunction with cleanTearDown:
1) loads our html fixture
2) sets up spys & stubs objects to be auto restored on test completion
"""
exports.cleanSetup = (ctx, fixtureHtml) ->

  if fixtureHtml? then setHtmlfixture fixtureHtml

  # add objects to hold spys + stubs that we can gracefully clean up in tear_down
  ctx.spys = {}
  ctx.stubs = {}

""" cleanTearDown
called in conjunction with cleanSetup:
1) clears our html fixture
2) auto restores spys and stubs
3) switches off the current router
"""
exports.cleanTearDown = (ctx) ->

  # restore all our spys & stubs
  for own attr, value of ctx.spys
    ctx.spys[attr].restore()

  for own attr, value of ctx.stubs
    ctx.stubs[attr].restore()

  clearHtmlfixture()

  # stop our router doing anything before "beforeEach" executes for next test
  if window.router?
    # so we can press refresh in the browser easily
    router.navigate '#'
    Backbone.history.stop()


module.exports = exports
