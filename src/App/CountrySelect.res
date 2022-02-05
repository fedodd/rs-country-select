%%raw("import 'flag-icons/css/flag-icons.min.css'")
%%raw("import './styles/CountrySelect.scss'")

let errorStyle = Emotion.css({
  "color": "red",
})

let getComponentsWithListRef = listRef => {
  let components: ReactSelect.components = {
    dropdownIndicator: () => <SearchIcon />,
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
  let components = getComponentsWithListRef(listRef)

  let (options: array<Api.countryItem>, setOptions) = React.useState(_ => [])
  let (menuIsOpen, setMenuIsOpen) = React.useState(_ => false)
  let (error: string, setError) = React.useState(_ => "")
  let (isError: bool, setIsError) = React.useState(_ => false)

  let onToggleHandler = (_event: ReactEvent.Mouse.t) => setMenuIsOpen(_ => !menuIsOpen)

  let onChangeHandler = (country: Api.countryItem) => {
    onChange(country.value)
    setMenuIsOpen(_ => false)
  }

  let currentCountry = Js.Array2.find(options, option => option.value === country)

  React.useEffect0(() => {
    let _ = {
      open Promise
      Api.Country.getCountries()
      ->Promise.then(result => {
        switch result {
        | Ok(countries) => setOptions(_ => countries)
        | Error(msg) => {
            setIsError(_ => true)
            setError(_ => "Could not query countries: " ++ msg)
          }
        }->resolve
      })
      ->catch(e => {
        switch e {
        | Api.FailedRequest(msg) => setError(_ => "Operation failed! " ++ msg)
        | _ => setError(_ => "Unknown error")
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
          let currentIndex = Js.Array2.findIndex(options, option => option.value === itemData.value)
          // scroll on move from start to end of a list, and backward
          let indexToScroll = switch key {
          | "ArrowUp" => currentIndex === 0 ? Js.Array2.length(options) : currentIndex - 1
          | _ => currentIndex === Js.Array2.length(options) - 1 ? 0 : currentIndex + 1
          }
          listEl.scrollToItem(. indexToScroll, "auto")
        }
      }
    }
  }

  <div className>
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
      {switch isError {
      | true => <span className={errorStyle}> {React.string(error)} </span>
      | false =>
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
      }}
    </DropDown>
  </div>
}
