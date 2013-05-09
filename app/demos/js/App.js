(function() {
  var BB, Page, collections, models, routers, views;

  try {
    require('./../../stubs/base');
  } catch (_error) {}

  BB = require('./../../lib/badassbackbone');

  models = require('./Models');

  collections = require('./Collections');

  views = require('./Views');

  routers = require('./Routers');

  module.exports.Page = Page = (function() {

    function Page(pageData) {

    }

    return Page;

  })();

  //module.exports.Router = routers.DevelopersRouter;

  module.exports.LoadSPA = function() {
    return window.initSPA(module.exports);
  };

  $(function() {
    return module.exports.LoadSPA();
  });

}).call(this);
