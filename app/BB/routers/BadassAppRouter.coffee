"""
  BadassAppRouter takes the philosophical position that only one router
  can be used for one html page / single page app and it is the top most
  app container object other than window.

  A bad ass router knows how to construct all the pieces of a page using
  @appConstructor. This includes all models, collections and views.

  It also assumes that each route has an associated top level views
  which becomes visible when you hit that route and all other become hidden
"""
module.exports = class BadassAppRouter extends Backbone.Router

  # Set logging on /off - Very dandy during dev to see flow of routes
  logging: off

  # Set off if you don't want pushSate - great during testing!
  pushState: on

  # Almost always a good idea to override pushStateRoot in child router
  pushStateRoot: '/'

  # Good to turn off during testing & admin pages
  enableExternalProviders: on

  # takes pageData to pre-load data into the SPA without ajax calls
  constructor: (pageData, callback) ->

    if @logging
      history = "pushState: #{@pushState}, root: #{@pushStateRoot}"
      $log 'BadassRouter.ctor', history, @pageData, callback

    @pageData = pageData if pageData?

    app = @appConstructor pageData, callback
    @app = if @app? then _.extend @app, app else app

    if @logging
      $log 'BadassRouter.app', @app

    @initialize = _.wrap @initialize, (fn, args) =>

      Backbone.history.start pushState: @pushState, root: @pushStateRoot
      defaultFragment = Backbone.history.getFragment()

      if @pushState
        @enablePushStateNavigate()

      if @logging then $log "Router.init", args, @app
      fn.call @, args

      # $log 'defaultFragment', defaultFragment
      if defaultFragment != currentFragment = Backbone.history.getFragment()
        @navTo defaultFragment

      # wire up our 3rd party provider scripts to load only after our spa
      # had been initialized and constructed
      if @enableExternalProviders
        @loadExternalProviders()

    @wrapRoutes()

    # Call backbone to correctly wire up & call Router.initialize
    Backbone.Router::constructor.apply @, arguments


  # Construct all models/ collections & views for our SPA, the will be
  # assigned onto window.router.app (in the constructor) having them all
  # accessible means easy testing, stubbing of all objects that make up
  # our SPA
  appConstructor: (pageData, callback) ->
    throw new Error 'override appConstructor in child router & build all models, collections & views then return single objects'


  # automatically wrap route handlers
  # adding div hide/show + console logging (if enabled)
  wrapRoutes: ->

    for route of @routes

      # routes may contain /:id etc. - we only use
      # the first fragment to map to the fn name
      routeName = route.replace(/:id/g,'').split('/')[0]

      # can map empty routes twice to do default route
      if routeName != ''
        @[routeName] = (->) if !@[routeName]? # default function allows us to be lazy in child routers
        @[routeName].routeName = routeName
        @[routeName] = _.wrap @[routeName], (fn, args) =>
          if @logging then $log "Router.#{fn.routeName}"
          $(".route").hide()
          $("##{fn.routeName}").show()
          window.scrollTo 0, 0
          @routeMiddleware fn
          fn.call @, args

  # override routeMiddleware to execute custom code on every route
  routeMiddleware: (routeFn) ->

  # load external providers like google analytics, user-voice etc.
  loadExternalProviders: ->

  # prefer trigger to always be true
  # pass false as second arg for false
  navTo: (routeUrl, trigger) ->
    trigger = true if !trigger?

    # re-execute code
    currentFragment = Backbone.history.getFragment()
    if currentFragment == routeUrl && trigger
      # $log 'currentFragment', currentFragment
      @navigate '/#temp' # move to a temp route so we re-execute the code

    @navigate routeUrl, { trigger: trigger }


  # setup the ajax links for the html5 push navigation
  enablePushStateNavigate:  ->
    $("body").on "click", "a", (e) =>
      $a = $(e.currentTarget)
      href = $a.attr 'href'
      # $log 'href', href, href.length, $a, $a.hasClass 'routeIgnore'
      if href.length && href.charAt(0) is '#'

        # TODO: add ignore classes
        # if ! $a.hasClass 'routeIgnore'
        e.preventDefault()
        @navTo href.replace('#','')


  # short hand to handle injection of pageData for pre-loading models
  setOrFetch: (model, data, opts) ->
    if data? then return model.set data
    opts = {} if !opts?
    opts.reset = true # backbone 1.0 so slow without this set
    model.fetch opts


  # short hand to handle injection of pageData for pre-loading collections
  resetOrFetch: (collection, data, opts) ->
    if data? then return collection.reset data
    opts = {} if !opts?
    opts.reset = true # backbone 1.0 so slow without this set
    collection.fetch opts
