%%raw("import './App.css'")
let container = Emotion.css({
  "fontFamily": "Arial",
  "fontSize": "14px",
  "lineHeight": "18px",
  "color": "#333333",
  "maxWidth": 240
  
})

@react.component

let make = () => {
  
    let (country: string, setCountry) = React.useState(_ => "us")

  <div className={container}>
    <CountrySelect className="country-select" country onChange={value => setCountry(_ => value)}/> 
  </div>
}