module.exports =

  initialiseGA: ->
    if !window._gaq?
      window._gaq = []
      _gaq.push(['_setAccount', 'UA-XXXXXXXX-N'])
      _gaq.push(['_trackPageview'])
  
      (->
        ga = document.createElement('script')
        ga.type = 'text/javascript'
        ga.async = true
        gajs = '.google-analytics.com/ga.js'
        ga.src = if 'https:' is document.location.protocol then 'https://ssl'+gajs else 'http://www'+gajs
        s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s)
      )()

  trackRouteWithGA: (routeFn) ->
    # https://developers.google.com/analytics/devguides/collection/gajs/eventTrackerGuide
    _gaq?.push ['_trackEvent', 'route', routeFn.routeName, window.location]
