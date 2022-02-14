type selectProps = {value: Js.Nullable.t<Api.countryItem>}

type menuListProps = {
  options: array<Api.countryItem>,
  children: React.element,
  focusedOption: Js.Nullable.t<Api.countryItem>,
  maxHeight: int,
  innerRef: unit => React.element,
  selectProps: selectProps,
  value: Js.Nullable.t<Api.countryItem>,
  getValue: unit => Js.Nullable.t<array<Api.countryItem>>,
}

type optionInnerProps = {
  id: string,
  onClick: ReactEvent.Mouse.t => unit,
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

@module("react-select") @react.component
external make: (
  ~value: option<Api.countryItem>,
  ~options: array<Api.countryItem>,
  ~onChange: Api.countryItem => unit,
  ~autoFocus: bool,
  ~onKeyDown: ReactEvent.Keyboard.t => unit,
  ~controlShouldRenderValue: bool,
  ~menuIsOpen: bool,
  ~placeholder: string,
  ~components: components,
  ~classNamePrefix: string,
  ~escapeClearsValue: bool,
  ~tabSelectsValue: bool,
) => React.element = "default"
