// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var App = require("./App/App.bs.js");
var React = require("react");
var ReactDom = require("react-dom");

var root = document.querySelector("#root");

if (!(root == null)) {
  ReactDom.render(React.createElement(React.StrictMode, {
            children: React.createElement(App.make, {})
          }), root);
}

/* root Not a pure module */
