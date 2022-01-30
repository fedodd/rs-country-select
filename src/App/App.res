module Styles = {
  open Emotion
  let container = css({
    "fontFamily": "Arial, Helvetica, sans-serif",
    "fontSize": "14px",
    "lineHeight": "18px",
    "color": "#333333",
    "display": "flex",
    "justifyContent": "center",
    "marginTop": "220px",
  })

  let list = css({
    "border": "1px solid #d9dddd",
  })

  let listItem = css({
    "display": "flex",
    "alignItems": "center",
    "justifyContent": "center",
    "&:nth-child(2n)": {
      "backgroounColor": "lightblue",
    },
  })
}

module Row = {
  @react.component
  let make = (~style: ReactDOM.style, ~index: int) =>
    <div style={style} className={Styles.listItem}> {React.int(index)} </div>
}

// let items: array<React.element> = []

@react.component
let make = () => {
  let (country: string, setCountry) = React.useState(_ => "us")

  <div className={Styles.container}>
    <CountrySelect className="country-select" country onChange={value => setCountry(_ => value)} />
    <ReactWindow height=300 width=300 itemSize=60 itemCount=5 className={Styles.list}>
      {({style, index}) => <Row style index />}
    </ReactWindow>
  </div>
}
