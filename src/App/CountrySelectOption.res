module Styles = {
  open Emotion
  let option = css({
    "display": "flex",
    "gap": "8px",
    "width": "100%",
    "height": "100%",
    "color": "#333333",
    "alignItems": "center",
    "paddingLeft": 10,
    "paddingRight": 16,
    "&:hover": {
      "backgroundColor": "#eeeeee",
    },
  })

  let focused = css({
    "backgroundColor": "#eeeeee",
  })

  let selected = css({
    "backgroundColor": "#dddddd",
  })

  let flag = css({
    ".fi&": {
      "width": "14px",
      "height": "10px",
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
    className={`${Styles.option} ${isFocused ? Styles.focused : ""} ${isSelected
        ? Styles.selected
        : ""}`}
    id={innerProps.id}
    onClick={innerProps.onClick}
    onMouseOver={innerProps.onMouseOver}
    tabIndex={innerProps.tabIndex}>
    <span className={`fi fi-${option.value} ${Styles.flag}`} />
    <span> {React.string(option.label)} </span>
  </div>
}
