module Styles = {
  open Emotion
  let app = css({
    "display": "flex",
    "justifyContent": "center",
    "marginTop": "220px",
    "fontFamily": "Arial, Helvetica, sans-serif",
    "fontSize": "14px",
    "lineHeight": "18px",
    "color": "#333333",
  })
}

@react.component
let make = () => {
  let (country: string, setCountry) = React.useState(_ => "sg")

  <div className={Styles.app}>
    <CountrySelect className="country-select" country onChange={value => setCountry(_ => value)} />
  </div>
}
