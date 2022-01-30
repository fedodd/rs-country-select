// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as Css from "@emotion/css";

var option = Css.css({
      display: "flex",
      gap: "8px",
      color: "#333333",
      alignItems: "center",
      paddingLeft: 10,
      paddingRight: 16
    });

var flag = Css.css({
      ".fi&": {
        width: "14px",
        height: "10px"
      }
    });

var Styles = {
  option: option,
  flag: flag
};

function CountrySelectOption(Props) {
  var option$1 = Props.option;
  return React.createElement("div", {
              className: option
            }, React.createElement("span", {
                  className: "fi fi-" + option$1.value + " " + flag
                }), React.createElement("span", undefined, option$1.label));
}

var make = CountrySelectOption;

export {
  Styles ,
  make ,
  
}
/* option Not a pure module */