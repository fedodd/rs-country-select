// Generated by ReScript, PLEASE EDIT WITH CARE

import * as $$Promise from "@ryyppy/rescript-promise/src/Promise.bs.js";
import * as Caml_exceptions from "rescript/lib/es6/caml_exceptions.js";

var $$Response = {};

function getCountries(param) {
  return $$Promise.$$catch(globalThis.fetch(" https://gist.githubusercontent.com/rusty-key/659db3f4566df459bd59c8a53dc9f71f/raw/4127f9550ef063121c564025f6d27dceeb279623/counties.json").then(function (res) {
                    return res.json();
                  }).then(function (data) {
                  var ret = (data == null) ? [] : data;
                  return Promise.resolve({
                              TAG: /* Ok */0,
                              _0: ret
                            });
                }), (function (e) {
                var msg;
                if (e.RE_EXN_ID === $$Promise.JsError) {
                  var msg$1 = e._1.message;
                  msg = msg$1 !== undefined ? msg$1 : "";
                } else {
                  msg = "Unexpected error occurred";
                }
                return Promise.resolve({
                            TAG: /* Error */1,
                            _0: msg
                          });
              }));
}

var Country = {
  getCountries: getCountries
};

var FailedRequest = /* @__PURE__ */Caml_exceptions.create("Api.FailedRequest");

export {
  $$Response ,
  Country ,
  FailedRequest ,
  
}
/* No side effect */
