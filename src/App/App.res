%%raw("import './App.css'")
let container = Emotion.css({
  "color": "#000",
  "backgroundColor": "red",
  "maxWidth": 240
})

@react.component

let make = () => {
  
    let (country: string, setCountry) = React.useState(_ => "us")

  <div className={container}>
    <CountrySelect className="country-select" country onChange={value => setCountry(_ => value)}/> 
  </div>
}