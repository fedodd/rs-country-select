%%raw("import 'flag-icons/css/flag-icons.min.css'")
%%raw("import './styles/CountrySelect.scss'")

module SearchIcon = {
  @module("./assets/search_icon.svg") @react.component
  external make: (~className: string) => React.element = "ReactComponent"
}

module Styles = {
  open Emotion
  let control = css({
    "minWidth": "230",
    "margin": "8",
  })
  let menu = {"boxShadow": "inset 0 1px 0 rgba(0, 0, 0, 0.1)"}

  let searchIcon = css({
    "color": "grey",
    "height": 13,
    "width": 13,
  })

  let dropdownIndicator = css({
    "order": "-1",
  })
}

let selectStyles = {
  "container": () =>
    Emotion.css({
      "width": "230px",
    }),
  "placeholder": () =>
    {
      "color": "red",
    },
  "control": () =>
    {
      "width": "230px",
      "height": "35px",
      "boxShadow": "inset 0px -1px 0px rgba(0, 0, 0, 0.08)",
      "backgroundColor": "rgba(255, 255, 255, 0.08)",
    },
  "dropdownIndicator": () =>
    {
      "order": "-1",
    },
}

module DropdownIndicator = {
  @react.component
  let make = () =>
    <div className={Styles.dropdownIndicator}> <SearchIcon className={Styles.searchIcon} /> </div>
}

@react.component
let make = (~country: string, ~className: string, ~onChange) => {
  let (options: array<Api.countryItem>, setOptions) = React.useState(_ => [])
  let (menuIsOpen, setMenuIsOpen) = React.useState(_ => false)
  let (_, setError) = React.useState(_ => "")

  let onToggleHandler = (_event: ReactEvent.Mouse.t) => setMenuIsOpen(_ => !menuIsOpen)

  // let defaultCountry

  let onChangeHandler = (country: Api.countryItem) => {
    // setCurrentCountry(_ => country)
    onChange(country.value)
    setMenuIsOpen(_ => false)
  }

  // type convertFunc = string => ReactSelect.value
  let currentCountry = Js.Array2.find(options, option => option.value === country)
  // let convertCountryToOption = (country: string) =>

  React.useEffect0(() => {
    let _ = {
      open Promise
      Api.Country.getCountries()
      ->Promise.then(result => {
        switch result {
        | Ok(countries) => setOptions(_prev => countries)
        | Error(msg) => setError(_prev => "Could not query countries: " ++ msg)
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

  let components: ReactSelect.components = {
    dropdownIndicator: () => <DropdownIndicator />,
    indicatorSeparator: () => React.null,
  }

  // let styles: ReactSelect.selectStylesRecord = {
  //   container: ((), ()) =>
  //     {
  //       "width": "400px",
  //     },
  // }

  // let filterOption = ReactSelect.createFilter({
  //   ignoreAccents: false,
  //   stringify: (option: ReactSelect.optionData) => option.data.label,
  // })

  let selectWrapper =
    <DropDown
      isOpen={menuIsOpen}
      onClose={onToggleHandler}
      target={<Button
        text={switch currentCountry {
        | Some(option) => option.label
        | None => ""
        }}
        onClick={onToggleHandler}
      />}>
      <ReactSelect
        value={currentCountry}
        defaultValue={"ru"}
        onChange={onChangeHandler}
        options
        // getOptionLabel={(option: Api.countryItem) => <OptionLabel option/>}
        placeholder="Search"
        menuIsOpen
        autoFocus={true}
        controlShouldRenderValue={false}
        classNamePrefix="--country-select"
        // styles={ReactSelect.mergeStyles(styles)}
        components
      />
    </DropDown>

  <div className>
    {switch Js.Array2.length(options) > 0 {
    | true => selectWrapper
    | false => React.null
    }}
  </div>
}
