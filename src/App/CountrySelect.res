module ReactSelect = {
  
  @module("react-select") @react.component
  external make:(
    ~className: string=?,
    ~value: string,
    ~options: array<Api.countryItem>,
    // ~onChange: (event?: React.ChangeEvent<HTMLInputElement>, newValue?: string)
    ) => React.element = "default"
}


@react.component
let make = (~country: string, ~className: string) => {  

  let (options: array<Api.countryItem>, setOptions) = React.useState(_ => [])
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

  <div className>
      {switch Js.Array2.length(options) > 0  {
      | true => <ReactSelect
      value={country}
      // onChange={this.handleChange}
      options
    />
    | false => React.string(error)
    }}
  </div>
}