%%raw("import 'flag-icons/css/flag-icons.min.css'")

module SearchIcon = {
  @module("./assets/search_icon.svg") @react.component
  external make: (~className: string) => React.element = "ReactComponent"
}

module ReactSelect = {

  type components = {
    @as("DropdownIndicator")
    dropdownIndicator: unit => React.element,
    @as("IndicatorSeparator")
    indicatorSeparator: unit => React.element,
    @as("SelectContainer")
    // selectContainer: unit => React.element,
  }

  @module("react-select") @react.component
  external make:(
    ~value: Api.countryItem,
    ~defaultValue: Api.countryItem,
    ~options: array<Api.countryItem>,
    ~getOptionLabel: Api.countryItem => React.element,
    ~onChange: (Api.countryItem) => unit,
    ~autoFocus: bool,
    ~openMenuOnFocus: bool=?,
    // ~onFocus
    // ~onKeyDown
    // ~backspaceRemovesValue={false}
    // ~components={{ DropdownIndicator, IndicatorSeparator: null }}
    ~controlShouldRenderValue: bool,
    // ~hideSelectedOptions={false}
    // ~isClearable={false}
    ~menuIsOpen: bool,
    ~placeholder: string,
    ~components: components=?,
    // ~styles: 'a=?
    // ~tabSelectsValue={false}
    ) => React.element = "default"
}

module Styles = {
  open Emotion
  let control =  css({
    "minWidth": "230",
    "margin": "8",
  })
  let menu = ({ "boxShadow": "inset 0 1px 0 rgba(0, 0, 0, 0.1)" })


  let searchIcon = css({
    "color": "grey",
    "height": 13,
    "width": 13,
  })

  let dropdownIndicator = css({
    "order": "-1"
  })

}

let selectStyles = {
  "container": () => Emotion.css({
    "width": "230px"
  }),
  "placeholder": () => ({
    "color": "red",
  }),
  "control": () => ({
    "width": "230px",
    "height": "35px",
    "boxShadow": "inset 0px -1px 0px rgba(0, 0, 0, 0.08)",
    "backgroundColor": "rgba(255, 255, 255, 0.08)",
  }),
  "dropdownIndicator": () => ({
    "order": "-1"
  })
}

module DropdownIndicator = {
  @react.component
  let make = () => 
    <div className={Styles.dropdownIndicator}>
      <SearchIcon className={Styles.searchIcon}/>
    </div>
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


  let components: ReactSelect.components = {
    dropdownIndicator: () => <DropdownIndicator />, 
    indicatorSeparator: () => React.null,
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
            components
          />
      </DropDown>

  <div className>
      {switch Js.Array2.length(options) > 0  {
      | true => selectWrapper
      | false => React.null
    }}
  </div>
}
