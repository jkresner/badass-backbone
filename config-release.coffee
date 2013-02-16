{config} = require './config'

config.files.javascripts.joinTo =
  # we exclude the stubs field in the release build
  'javascripts/app.js': /^app(\/|\\)(?!stubs)/
  'javascripts/vendor.js': /^vendor/
  # note removed test files from the release build
  # 'test/javascripts/test.js': /^test(\/|\\)(?!vendor)/
  # 'test/javascripts/test-vendor.js': /^test(\/|\\)(?=vendor)/

config.files.stylesheets.joinTo =
  'stylesheets/app.css': /^(app|vendor)/
  # note removed test stylesheets from the release build

exports.config = config