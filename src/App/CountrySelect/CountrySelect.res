module ReactSelect = {
  
  @module("react-select") @react.component
  external make:(
    ~value: string=?,
    ~defaultValue: Api.countryItem,
    ~options: array<Api.countryItem>,
    ~getOptionLabel: Api.countryItem => React.element,
    ~onChange: (Api.countryItem) => unit
    ) => React.element = "default"
}

@react.component
let make = (~country: string, ~className: string, ~onChange) => {  

  let (options: array<Api.countryItem>, setOptions) = React.useState(_ => [])
  let (currentCountry, setCurrentCountry) = React.useState(_=> ({value: "us", label: "Unated States"}: Api.countryItem)
  )
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

  React.useEffect1(() => {

    switch Js.Array2.find(options, option => option.value === country) {
    | Some(option) => setCurrentCountry(_ => option)
    | None => ()
    }
    None
  }, [options])

  let onChangeHandler = (country: Api.countryItem) => {
    setCurrentCountry(_ => country)
    onChange(country.value)
  }

  <div className>
      {switch Js.Array2.length(options) > 0  {
      | true => <ReactSelect
          // value={country}
          defaultValue={currentCountry}
          onChange={onChangeHandler}
          options
          getOptionLabel={(option: Api.countryItem) => <OptionLabel option/>}
        />
      | false => React.string(error)
    }}
  </div>
}