module ReactSelect = {
  
  @module("react-select") @react.component
  external make:(
    ~value: string=?,
    ~defaultValue: Api.countryItem,
    ~options: array<Api.countryItem>,
    ~onChange: (Api.countryItem) => unit
    ) => React.element = "default"
}


@react.component
let make = (~country: string, ~className: string, ~onChange) => {  

  let (options: array<Api.countryItem>, setOptions) = React.useState(_ => [])
  // let (currentCountry, setCurrentCountry) = React.useState(_=> "")
  let (error, setError) = React.useState(_=> "")

  React.useEffect0(() => {

    let _ = {
      open Promise
      Api.Country.getCountries()
      ->Promise.then(result => {
        switch result {
        | Ok(countries) =>
          setOptions(_prev => countries)
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

  // let onChangeHandler = (select, newCountry: Api.countryItem) => onChange(newCountry.value)

  <div className>
      {switch Js.Array2.length(options) > 0  {
      | true => <ReactSelect
          // value={country}
          defaultValue={value: "us", label: "Unated States"}
          onChange={(country: Api.countryItem) => {
            Js.log(country)
            onChange(country.value)
          }}
          options
        />
      | false => React.string(error)
    }}
  </div>
}