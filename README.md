# Badass Brunch

Baddass Brunch is a [Brunch](http://brunch.io/) app skeleton that comes with Bootstrap + Backbone + CoffeeScript and some useful base Backbone classes with examples on how to use them.

## Live demo

The app and each of the examples can be viewed at:


### http://airpair.us/index.html


## Getting started locally

1. <b>Install Brunch Server:</b> sudo npm install brunch -g
1. <b>Create App Locally:</b> brunch new {appname} --skeleton git@github.com:jkresner/badass-backbone-brunch.git
3. <b>Get node modules needed by brunch:</b> npm install
4. <b>Run brunch server in watch mode:</b> brunch watch --server
5. <b>Open app</b> http://localhost:3333/


## Useful Backbone Base Classes

- FilteringCollection
- PagingAndFilteringCollection
- ErrorStateView
- ModelSaveView

## Useful Brunch Tricks

- config-release.coffee


## Languages

- [CoffeeScript](http://coffeescript.org/)
- [Handlebars](http://handlebarsjs.com/)

## Awesome Included Libraries / Tools

- [HTML5 Boilerplate v3.0.0](https://github.com/h5bp/html5-boilerplate)
- [Bootrap 2.3.0](https://github.com/twitter/bootstrap)
- [Modernizr v2.6.2](https://github.com/Modernizr/Modernizr)
- [Lodash v1.0.0-rc.3](https://github.com/bestiejs/lodash)
- [Backbonejs v0.9.10](https://github.com/documentcloud/backbone)
- [Coffeelint 1.4.4](https://github.com/ilkosta/coffeelint-brunch)

## Testing Libraries / Tools

- [Mocha 0.14.0](https://github.com/visionmedia/mocha)
- [Chai 1.2.0](https://github.com/chaijs/chai)
- [Sinon 1.4.2](https://github.com/cjohansen/Sinon.JS)
- [Sinon-Chai 2.1.2](https://github.com/domenic/sinon-chai)


## Building in release mode

    brunch b --config config-release.coffee