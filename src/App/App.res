@react.component

let make = () => {
  let (countrySelects: array<Api.countryItem>, setCountrySelects) = React.useState(_ => [])
  let (error, setError) = React.useState(_=> "")

  React.useEffect0(() => {

    let _ = {
      open Promise
      Api.Country.getCountries()
      ->Promise.then(result => {
        switch result {
        | Ok(countries) =>
          setCountrySelects(_prev => countries)
        | Error(msg) =>setError(_prev => "Could not query countries: " ++ msg)
        }->resolve
      })
      ->catch(e => {
        switch e {
        | Api.FailedRequest(msg) => setError(_prev => "Operation failed! " ++ msg)
        | _ => setError(_prev => "Unknown error")
        }
        resolve()
      })
    }
    None 
  })

  // let items = {Js.Array2.map(countrySelects, elem => <li>{React.string(elem.value)} {React.string(elem.label)}</li>)}

  <div>
    {switch Js.Array2.length(countrySelects) > 0  {
    | true => <CountrySelect value={countrySelects[0]} options={countrySelects}/> 
    | false => React.string(error)
    }}
    // <ul>{React.array(items)}</ul>
  </div>
}