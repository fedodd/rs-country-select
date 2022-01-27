let buttonStyle = Emotion.css({
  "display": "flex",
  "alighItems": "center",
  "paddingLeft": 10,
  "paddingRight": 10,
  "borderRadius": 2,
  "border": "1px solid rgba(0, 0, 0, 0.2)",
  "backgroundColor": "#ffffff",
  "marginBottom": 2

})

@react.component
let make = (~text: string, ~onClick) => 
  <div onClick className={buttonStyle}>
    <span>{React.string(text)}</span>
  </div>
