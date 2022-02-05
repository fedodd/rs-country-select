// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as Css from "@emotion/css";
import * as ArrowSvg from "./assets/arrow.svg";

var make = ArrowSvg.ReactComponent;

var ArrowIcon = {
  make: make
};

var button = Css.css({
      position: "relative",
      display: "flex",
      gap: 5,
      justifyContent: "space-between",
      alignItems: "center",
      paddingLeft: 9,
      paddingRight: 9,
      borderRadius: 2,
      border: "1px solid rgba(0, 0, 0, 0.2)",
      backgroundColor: "#ffffff",
      width: 119,
      height: 26,
      boxSizing: "border-box",
      fontFamily: "inherit",
      fontSize: "inherit",
      "&:hover": {
        cursor: "pointer"
      }
    });

var buttonText = Css.css({
      display: "flex",
      background: "inherit",
      whiteSpace: "nowrap",
      textOverflow: "ellipsis",
      overflow: "hidden",
      "&:hover": {
        textOverflow: "unset",
        overflow: "visible",
        whiteSpace: "break"
      }
    });

var buttonIcon = Css.css({
      flexShrink: 0
    });

var Styles = {
  button: button,
  buttonText: buttonText,
  buttonIcon: buttonIcon
};

function Button(Props) {
  var text = Props.text;
  var onClick = Props.onClick;
  return React.createElement("button", {
              className: button,
              onClick: onClick
            }, React.createElement("span", {
                  className: buttonText
                }, text), React.createElement(make, {
                  className: buttonIcon
                }));
}

var make$1 = Button;

export {
  ArrowIcon ,
  Styles ,
  make$1 as make,
  
}
/* make Not a pure module */
