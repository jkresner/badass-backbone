BB = require 'badass-backbone'
C = require './collections'
M = require './models'
D = require './../../stubs/tags'
#V = require './views'

# Inherit from BadassAppRouter to get Badass Backbone conventions
module.exports = class Router extends BB.BadassAppRouter

  logging: on
	
	routes:
		'' : 'tagsView'


  appConstructor: (pageData, callback) ->
		
    d = # d is shorthand for 'data', i.e. models & collections
      tags: new C.Tags D
      #employee: new M.Employee()

    v = {}# v is shorthand for views
      #step1View: new V.Step1View el: '#step1', model: d.company
      #step2View: new V.Step2View el: '#step2', model: d.employee
      #step3View: new V.Step3View el: '#step3'
			
    _.extend d, v


  tagsView: ->
    $log @app.tags
		