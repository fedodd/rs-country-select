type selectProps = {value: Js.Nullable.t<Api.countryItem>}

type menuListProps = {
  options: array<Api.countryItem>,
  children: React.element,
  focusedOption: Js.Nullable.t<Api.countryItem>,
  maxHeight: int,
  innerRef: unit => React.element,
  selectProps: selectProps,
}

type optionInnerProps = {
  id: string,
  onClick: ReactEvent.Mouse.t => unit,
  onMouseOver: ReactEvent.Mouse.t => unit,
  tabIndex: int,
}

type optionProps = {
  data: Api.countryItem,
  innerProps: optionInnerProps,
  isFocused: bool,
  isSelected: bool,
}

type components = {
  @as("DropdownIndicator")
  dropdownIndicator: unit => React.element,
  @as("IndicatorSeparator")
  indicatorSeparator: unit => React.element,
  @as("MenuList")
  menuList: menuListProps => React.element,
  @as("Option")
  option: optionProps => React.element,
}

type optionData = {data: Api.countryItem}

type filterProps = {
  ignoreAccents: bool,
  stringify: optionData => string,
}

// here don't need to bind result, cause it is a function to set parameters, and only this parameters we set
@module("react-select") external createFilter: filterProps => 'a = "createFilter"

@module("react-select") @react.component
external make: (
  ~value: option<Api.countryItem>,
  ~options: array<Api.countryItem>,
  ~getOptionLabel: Api.countryItem => React.element=?,
  ~onChange: Api.countryItem => unit,
  ~autoFocus: bool,
  ~openMenuOnFocus: bool=?,
  ~filterOption: filterProps => unit=?,
  ~onKeyDown: ReactEvent.Keyboard.t => unit,
  ~controlShouldRenderValue: bool,
  ~menuIsOpen: bool,
  ~placeholder: string,
  ~components: components=?,
  ~classNamePrefix: string,
  ~escapeClearsValue: bool,
  ~tabSelectsValue: bool=?,
) => React.element = "default"
