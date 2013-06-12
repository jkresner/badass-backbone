About
===============================================================================

Baddass Backbone is a minimalist set of abstract models, collections and views that stay close to backbone philosophy and greatly reduce code.

The classes have been built with app testing as top priority. In this project you will find methods and approaches to both unit and integration style testing.

## Live demo & documentation

### http://badass-backbone.hackerpreneurialism.com/


Setting up & running locally
===============================================================================

1. Install Brunch Server: `sudo npm install brunch -g`

2. Get node modules: `npm install`

3. Install mocha, PhantomJS & mocha-phantomjs (For testing) `sudo npm install -g mocha mocha-phantomjs phantomjs`

4. Run brunch server: `brunch watch --server`

5. Open app => http://localhost:3333/


Integration Testing
===============================================================================


*** Where your test code lives and gets built

Brunch compiles all files inside of /test (dir) that end with '_test' into /test/javascript/test.js

Brunch also combines all files inside of /test/vendor into /test/javascript/test-vendor.js

(you can see and configure this in /config.coffee)


*** How your test code gets executed

Brunch then build all .html files in /test/assets/test & builds then into /public/test/assets/test

So for example, you can hit in your browser

http://localhost:3333/test/index.html

Where index.html is a mocha test harness page that includes test.js and test-vendor.js

*** Continuous Integration

You can also execute your tests from the terminal using mocha-phantom and this way incorporate your tests into
Continuous Integration.

mocha-phantomjs http://localhost:3333/test/index.html

Note you need to have brunch running while you execute you mocha-phantomjs (duh)

*** Execute only specific tests

Inside your test/*.html file you can control what tests get executed using the mocha grep (-g) option.

/test/index.html has no grep option, so it is setup to run all of your tests. You can uncomment and add any string regex to run a single suite or even a single test or a mixture of tests with matching strings.

see /test/grep.html for how it works. We recommend creating separate /test/*.html files to execute groups of tests and leaving /test/index.html to run all your tests in CI and such.


In progress (things JK is working on next)
===============================================================================

1) Site wide layout with sharing stuff
2) Incorporate Travis CI into badass-backbone