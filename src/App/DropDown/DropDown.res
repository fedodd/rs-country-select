
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
    "borderRadius": 2,
    "marginTop": 2,
    "position": "absolute",
    "zIndex": 2,
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