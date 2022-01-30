type components = {
  @as("DropdownIndicator")
  dropdownIndicator: unit => React.element,
  @as("IndicatorSeparator")
  indicatorSeparator: unit => React.element,
}

// type customStyles = {"width": string}
// type selectStylesRecord = {container: (unit, unit) => customStyles}
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
  ~defaultValue: string,
  ~options: array<Api.countryItem>,
  ~getOptionLabel: Api.countryItem => React.element=?,
  ~onChange: Api.countryItem => unit,
  ~autoFocus: bool,
  ~openMenuOnFocus: bool=?,
  ~filterOption: filterProps => unit=?,
  // ~getStyles: (string, _) => ReactDOM.style.t=?,
  // ~onFocus
  // ~onKeyDown
  // ~backspaceRemovesValue={false}
  ~controlShouldRenderValue: bool,
  // ~hideSelectedOptions={false}
  // ~isClearable={false}
  ~menuIsOpen: bool,
  ~placeholder: string,
  ~components: components=?,
  ~classNamePrefix: string,
) => // ~styles: selectStylesRecord => unit=?,
// ~tabSelectsValue={false}
React.element = "default"