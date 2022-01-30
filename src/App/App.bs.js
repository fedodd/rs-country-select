// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "rescript/lib/es6/curry.js";
import * as React from "react";
import * as Css from "@emotion/css";
import * as CountrySelect from "./CountrySelect.bs.js";

var container = Css.css({
      fontFamily: "Arial, Helvetica, sans-serif",
      fontSize: "14px",
      lineHeight: "18px",
      color: "#333333",
      display: "flex",
      justifyContent: "center",
      marginTop: "220px"
    });

var Styles = {
  container: container
};

function App(Props) {
  var match = React.useState(function () {
        return "us";
      });
  var setCountry = match[1];
  return React.createElement("div", {
              className: container
            }, React.createElement(CountrySelect.make, {
                  country: match[0],
                  className: "country-select",
                  onChange: (function (value) {
                      return Curry._1(setCountry, (function (param) {
                                    return value;
                                  }));
                    })
                }));
}

var make = App;

export {
  Styles ,
  make ,
  
}
/* container Not a pure module */
