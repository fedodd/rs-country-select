module ArrowIcon = {
  @module("./assets/arrow.svg") @react.component
  external make: (~className: string) => React.element = "ReactComponent"
}

module Styles = {
  open Emotion
  let button = css({
    "position": "relative",
    "display": "flex",
    "gap": 5,
    "justifyContent": "space-between",
    "alignItems": "center",
    "paddingLeft": 9,
    "paddingRight": 9,
    "borderRadius": 2,
    "border": "1px solid rgba(0, 0, 0, 0.2)",
    "backgroundColor": "#ffffff",
    "width": 119,
    "height": 26,
    "boxSizing": "border-box",
    "fontFamily": "inherit",
    "fontSize": "inherit",
    "&:hover": {
      "cursor": "pointer",
    },
  })

  let buttonText = css({
    "display": "flex",
    "background": "inherit",
    "whiteSpace": "nowrap",
    "textOverflow": "ellipsis",
    "overflow": "hidden",
    "&:hover": {
      "textOverflow": "unset",
      "overflow": "visible",
      "whiteSpace": "break",
    },
  })

  let buttonIcon = css({
    "flexShrink": 0,
  })
}

@react.component
let make = (~text: string, ~onClick) =>
  <button onClick className={Styles.button}>
    <span className={Styles.buttonText}> {React.string(text)} </span>
    <ArrowIcon className={Styles.buttonIcon} />
  </button>
