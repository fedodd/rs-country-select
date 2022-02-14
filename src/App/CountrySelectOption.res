module Styles = {
  open Emotion
  let option = css({
    "display": "flex",
    "gap": "8px",
    "width": "100%",
    "height": "100%",
    "color": "#333333",
    "alignItems": "center",
    "paddingLeft": 9,
    "paddingRight": 16,
    "lineHeight": 1,
    "textOverflow": "ellipsis",
    "overflow": "hidden",
    "whiteSpace": "nowrap",
    "&:hover": {
      "backgroundColor": "#eeeeee",
      "whiteSpace": "normal",
    },
  })

  let focused = css({
    "backgroundColor": "#eeeeee",
    "whiteSpace": "normal",
  })

  let selected = css({
    "backgroundColor": "#dddddd",
    "whiteSpace": "normal",
  })

  let flag = css({
    ".fi&": {
      "width": "14px",
      "height": "10px",
      "flexShrink": "0",
    },
  })
}

@react.component
let make = (
  ~option: Api.countryItem,
  ~innerProps: ReactSelect.optionInnerProps,
  ~isFocused: bool,
  ~isSelected: bool,
) => {
  <div
    className={Emotion.cx([
      Styles.option,
      isFocused ? Styles.focused : "",
      isSelected ? Styles.selected : "",
    ])}
    id={innerProps.id}
    onClick={innerProps.onClick}
    tabIndex={innerProps.tabIndex}>
    <span className={`fi fi-${option.value} ${Styles.flag}`} />
    <span> {React.string(option.label)} </span>
  </div>
}
