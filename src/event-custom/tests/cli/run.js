#!/usr/bin/env node

process.chdir(__dirname);

var YUITest = require('yuitest'),
    path = require('path'),
    fs = require('fs'),
    dir = path.join(__dirname, '../../../../build-npm/'),
    YUI = require(dir).YUI,
    json;


YUI({useSync: true }).use('test', function(Y) {
    Y.Test.Runner = YUITest.TestRunner;
    Y.Test.Case = YUITest.TestCase;
    Y.Test.Suite = YUITest.TestSuite;
    Y.Assert = YUITest.Assert;
    Y.ArrayAssert = YUITest.ArrayAssert;
    Y.ObjectAssert = YUITest.ObjectAssert;

    Y.applyConfig({
        modules: {
            'event-do-tests': {
                fullpath: path.join(__dirname, '../event-do-tests.js'),
                requires: ['event-custom-base', 'test']
            },
            'event-custom-base-tests': {
                fullpath: path.join(__dirname, '../event-custom-base-tests.js'),
                requires: ['event-custom-base', 'test']
            }
        }
    });

    Y.use('event-do-tests', 'event-custom-base-tests');
    
    Y.Test.Runner.setName('event-custom cli tests');
    
});
