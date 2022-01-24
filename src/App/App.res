@react.component

let make = () => {
  let greetings = React.string("Hello World!!!123")

  let (countrySelects: array<Api.countryItem>, setCountrySelects) = React.useState(_ => [])
  let (state: string, setState) = React.useState(_ => "")

  React.useEffect0(() => {

    let _ = {
      open Promise
      Api.Country.getCountries()
      ->Promise.then(result => {
        switch result {
        | Ok(countries) =>
          setCountrySelects(_prev => countries)
        | Error(msg) => Js.log("Could not query countries: " ++ msg)
        }->resolve
      })
      ->catch(e => {
        switch e {
        | Api.FailedRequest(msg) => Js.log("Operation failed! " ++ msg)
        | _ => Js.log("Unknown error")
        }
        resolve()
      })
    }
    None 
  })


  <div>
    <p>greetings</p>
    <p>{React.string(state)}</p>
    // <ul>{Js.Array2.map(countrySelects, elem => React.string(elem.label))}</ul>
  </div>
}