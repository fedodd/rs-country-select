
module Blanket = {

  let blanketStyle = Emotion.css({
        "bottom": 0,
        "left": 0,
        "top": 0,
        "right": 0,
        "position": "fixed",
        "zIndex": 1,
  })

  @react.component
  let make = (~onClick) => <div onClick className={blanketStyle}/>
}

module Styles = {
  let dropDown = Emotion.css({
    "position": "relative",
  })

  let menu = Emotion.css({
    "marginTop": 2,
    "position": "absolute",
    "zIndex": 2,
    "width": 230,
    "height": 199,
    "boxShadow": "0px 1px 3px rgba(0, 0, 0, 0.1)",
    "borderRadius": 2,
    "border": "1px solid rgba(0, 0, 0, 0.08",
    "backgroundColor": "#ffffff",
  })
}

@react.component
let make = (
  ~children,
  ~isOpen: bool,
  ~target: React.element,
  ~onClose: (ReactEvent.Mouse.t) => unit,
) => (
  <div className={Styles.dropDown}>
    {target}
    {switch (isOpen) {
      | true => <div><div className={Styles.menu}>{children}</div><Blanket onClick={onClose}></Blanket></div>
      | false => React.null
    }}      
  </div>
);