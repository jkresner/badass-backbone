# # docs on using spy/fake/stub                   sinonjs.org/docs/
# # docs on expect syntax                         chaijs.com/api/bdd/
# # docs on sinon chai syntax                     chaijs.com/plugins/sinon-chai
# {_, $, $log, Backbone} = window
# hlpr = require './../../helper'
# BB = require 'lib/badassbackbone'


# class ExampleBadassView extends BB.BadassView
#   logging: off
#   autoSetConstructorArgs: on
#   initialize: (args) ->
#   render: ->
#   save: (e) ->



# describe 'BB.BadassView => ', ->

#   beforeEach ->
#     hlpr.clean_setup @
#     @model = new Backbone.Model id: 5, name: 'BadassModelTest'
#     @collection = new Backbone.Collection [{ id: 7, name: 'BadassCollecitonTest' }]


#   it 'does not set extra args with autoSetConstructor off', ->
#     v = new ExampleBadassView autoSetConstructorArgs: off, extra: 'ExtraAttr', model: @model, collection: @collection
#     expect(v.model.get 'name').to.equal 'BadassModelTest'
#     expect(v.collection.length).to.equal 1
#     expect(v.extra?).to.be.false


#   it 'does not set extra args with autoSetConstructor on (by default)', ->
#     v = new ExampleBadassView extra: 'ExtraAttr', model: @model, collection: @collection
#     expect(v.model.get 'name').to.equal 'BadassModelTest'
#     expect(v.collection.length).to.equal 1
#     expect(v.extra).to.be.equal 'ExtraAttr'


#   it 'does not die with empty args', ->
#     v = new ExampleBadassView()
#     expect(v.model?).to.be.false
#     expect(v.collection?).to.be.false


#   it 'does not log anything when logging set to off on Class definition', ->
#     @spys.$log = sinon.spy window, '$log'
#     v = new ExampleBadassView()
#     expect(@spys.$log.called).to.be.false
#     v.render()
#     v.save()
#     expect(@spys.$log.called).to.be.false


#   it 'does not log anything when logging set to off on Class definition', ->
#     @spys.$log = sinon.spy window, '$log'
#     v = new ExampleBadassView logging: on
#     expect(@spys.$log.calledOnce).to.be.true
#     v.render()
#     expect(@spys.$log.calledTwice).to.be.true
#     v.save()
#     expect(@spys.$log.calledThrice).to.be.true


#   afterEach ->
#     hlpr.clean_tear_down @