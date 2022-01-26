// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Api from "./Api.bs.js";
import * as Curry from "rescript/lib/es6/curry.js";
import * as React from "react";
import * as $$Promise from "@ryyppy/rescript-promise/src/Promise.bs.js";
import ReactSelect from "react-select";

var ReactSelect$1 = {};

function CountrySelect(Props) {
  var className = Props.className;
  var onChange = Props.onChange;
  var match = React.useState(function () {
        return [];
      });
  var setOptions = match[1];
  var options = match[0];
  var match$1 = React.useState(function () {
        return "";
      });
  var setError = match$1[1];
  React.useEffect((function () {
          $$Promise.$$catch(Api.Country.getCountries(undefined).then(function (result) {
                    var tmp;
                    if (result.TAG === /* Ok */0) {
                      var countries = result._0;
                      tmp = Curry._1(setOptions, (function (_prev) {
                              return countries;
                            }));
                    } else {
                      var msg = result._0;
                      tmp = Curry._1(setError, (function (_prev) {
                              return "Could not query countries: " + msg;
                            }));
                    }
                    return Promise.resolve(tmp);
                  }), (function (e) {
                  if (e.RE_EXN_ID === Api.FailedRequest) {
                    var msg = e._1;
                    Curry._1(setError, (function (_prev) {
                            return "Operation failed! " + msg;
                          }));
                  } else {
                    Curry._1(setError, (function (_prev) {
                            return "Unknown error";
                          }));
                  }
                  return Promise.resolve(undefined);
                }));
          
        }), []);
  return React.createElement("div", {
              className: className
            }, options.length > 0 ? React.createElement(ReactSelect, {
                    defaultValue: {
                      value: "us",
                      label: "Unated States"
                    },
                    options: options,
                    onChange: (function (country) {
                        console.log(country);
                        return Curry._1(onChange, country.value);
                      })
                  }) : match$1[0]);
}

var make = CountrySelect;

export {
  ReactSelect$1 as ReactSelect,
  make ,
  
}
/* react Not a pure module */
