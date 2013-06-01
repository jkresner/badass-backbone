global.$log = console.log

chai          = require 'chai'
chai.use require 'sinon-chai'
#require "sinon/lib/sinon/util/fake_xml_http_request"

global._ = require 'underscore'


module.exports =
  sinon:      require 'sinon'
  chai:       require 'chai'
  expect:     chai.expect
  Backbone:   require './../vendor/scripts/backbone'
  # BB:         require './../vendor/scripts/badass-backbone'