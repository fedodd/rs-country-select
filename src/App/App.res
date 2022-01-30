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
}

@react.component
let make = () => {
  let (country: string, setCountry) = React.useState(_ => "us")

  <div className={Styles.container}>
    <CountrySelect className="country-select" country onChange={value => setCountry(_ => value)} />
  </div>
}
