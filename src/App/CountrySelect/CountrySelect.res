%%raw("import 'flag-icons/css/flag-icons.min.css'")

module ReactSelect = {
  
  @module("react-select") @react.component
  external make:(
    ~value: Api.countryItem,
    ~defaultValue: Api.countryItem,
    ~options: array<Api.countryItem>,
    ~getOptionLabel: Api.countryItem => React.element,
    ~onChange: (Api.countryItem) => unit,
    ~autoFocus: bool,
    // ~backspaceRemovesValue={false}
    // ~components={{ DropdownIndicator, IndicatorSeparator: null }}
    ~controlShouldRenderValue: bool,
    // ~hideSelectedOptions={false}
    // ~isClearable={false}
    ~menuIsOpen: bool,
    ~placeholder: string,
    // ~styles={selectStyles}
    // ~tabSelectsValue={false}
    ) => React.element = "default"
  // external colors =>  = "colors"
  // external StylesConfig: = "StylesConfig"
}

// const { colors } = defaultTheme;

module Styles = {
  open Emotion
  // let container = css({
  //   "color": "#000",
  //   "backgroundColor": "red"
  // })
  // your other declarations
  let control =  css({
    // ...provided,
    "minWidth": "230",
    "margin": "8",
  })
  let menu = ({ "boxShadow": "inset 0 1px 0 rgba(0, 0, 0, 0.1)" })
}

@react.component
let make = (~country: string, ~className: string, ~onChange) => {  

  let (options: array<Api.countryItem>, setOptions) = React.useState(_ => [])
  let (currentCountry, setCurrentCountry) = React.useState(_=> ({value: "sg", label: "Singapore"}: Api.countryItem)
  )
  let (menuIsOpen, setMenuIsOpen) = React.useState(_=> false)
  let (error, setError) = React.useState(_=> "")

  let openToggleHandler = (event: ReactEvent.Mouse.t) => setMenuIsOpen(_ => !menuIsOpen)

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
    setMenuIsOpen(_=> !menuIsOpen)
  }

  let selectWrapper = 
      <DropDown isOpen={menuIsOpen} onClose={openToggleHandler}
        target={<Button text={currentCountry.label} onClick={openToggleHandler}/>}>
          <ReactSelect
            value={currentCountry}
            defaultValue={currentCountry}
            onChange={onChangeHandler}
            options
            getOptionLabel={(option: Api.countryItem) => <OptionLabel option/>}
            placeholder="Search..."
            menuIsOpen
            autoFocus={true}
            controlShouldRenderValue={false}
          />
      </DropDown>

  <div className>
      {switch Js.Array2.length(options) > 0  {
      | true => selectWrapper
      | false => React.null
    }}
  </div>
}