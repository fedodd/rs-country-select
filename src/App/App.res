%%raw("import 'flag-icons/css/flag-icons.min.css'")
%%raw("import './App.css'")

@react.component

let make = () => {
  
    let (country: string, setCountry) = React.useState(_ => "us")

  <div className="app">
    <p><span className="fi fi-gr"></span>{React.string("Greetings!")}</p>
    <CountrySelect className="country-select" country onChange={value => setCountry(_ => value)}/> 
  </div>
}