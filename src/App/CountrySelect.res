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
    "height": 13,
    "width": 13,
  })

  // let dropdownIndicator = css({
  //   "order": "-1",
  // })
}

module SearchIconComponent = {
  @react.component
  let make = () => <div> <SearchIcon className={Styles.searchIcon} /> </div>
}

let getComponentsWithListRef = listRef => {
  let components: ReactSelect.components = {
    dropdownIndicator: () => <SearchIconComponent />,
    indicatorSeparator: () => React.null,
    menuList: props =>
      <CountrySelectMenu menuProps={props} height=160 itemSize=26 listRef={listRef} />,
    option: ({data, innerProps, isFocused, isSelected}) =>
      <CountrySelectOption option={data} innerProps={innerProps} isFocused isSelected />,
  }
  components
}

@react.component
let make = (~country: string, ~className: string, ~onChange) => {
  let listRef = React.useRef(Js.Nullable.null)

  let (options: array<Api.countryItem>, setOptions) = React.useState(_ => [])
  let (menuIsOpen, setMenuIsOpen) = React.useState(_ => false)
  let (_, setError) = React.useState(_ => "")

  let onToggleHandler = (_event: ReactEvent.Mouse.t) => setMenuIsOpen(_ => !menuIsOpen)

  let onChangeHandler = (country: Api.countryItem) => {
    onChange(country.value)
    setMenuIsOpen(_ => false)
  }

  let currentCountry = Js.Array2.find(options, option => option.value === country)
  let components = getComponentsWithListRef(listRef)

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

  let onKeyDown = (event: ReactEvent.Keyboard.t) => {
    let key = ReactEvent.Keyboard.key(event)
    if key === "Escape" {
      onChange("")
      setMenuIsOpen(_ => false)
    }

    if key === "ArrowUp" || key === "ArrowDown" {
      switch Js.Nullable.toOption(listRef.current) {
      | None => ()
      | Some(listEl) =>
        switch Js.Nullable.toOption(listEl.props.itemData) {
        | None => ()
        | Some(itemData) =>
          let index = Js.Array2.findIndex(options, option => option.value === itemData.value)
          let indexToScroll = switch key {
          | "ArrowUp" => index === 0 ? Js.Array2.length(options) : index - 1
          | _ => index === Js.Array2.length(options) - 1 ? 0 : index + 1
          }
          listEl.scrollToItem(. indexToScroll, "auto")
        }
      }
    }
  }

  <div className>
    {switch Js.Array2.length(options) > 0 {
    | false => React.null
    | true =>
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
          onChange={onChangeHandler}
          options
          placeholder="Search"
          menuIsOpen
          autoFocus={true}
          controlShouldRenderValue={false}
          classNamePrefix="--country-select"
          components
          escapeClearsValue={true}
          onKeyDown
          tabSelectsValue={true}
        />
      </DropDown>
    }}
  </div>
}
