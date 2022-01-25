@react.component

let make = () => {
  
  // let items = {Js.Array2.map(countrySelects, elem => <li>{React.string(elem.value)} {React.string(elem.label)}</li>)}
    let (country: string, setCountry) = React.useState(_ => "us")

  <div className="app">
    <CountrySelect className="country-select" country /> 
    // <ul>{React.array(items)}</ul>
  </div>
}