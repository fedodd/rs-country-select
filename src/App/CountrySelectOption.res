module Styles = {
  open Emotion
  let option = css({
    "display": "flex",
    "gap": "8px",
    "color": "#333333",
    "alignItems": "center",
    "paddingLeft": 10,
    "paddingRight": 16,
  })

  let flag = css({
    ".fi&": {
      "width": "14px",
      "height": "10px",
    },
  })
}

@react.component
let make = (~option: Api.countryItem) => {
  <div className={Styles.option}>
    <span className={`fi fi-${option.value} ${Styles.flag}`} />
    <span> {React.string(option.label)} </span>
  </div>
}