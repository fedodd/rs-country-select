module ReactSelect = {
  
  @module("react-select") @react.component
  external make:(
    ~className: string=?,
    ~value: Api.countryItem,
    ~options: array<Api.countryItem>,
    // ~onChange: (event?: React.ChangeEvent<HTMLInputElement>, newValue?: string)
    ) => React.element = "default"
}


@react.component
let make = (~value: Api.countryItem, ~options: array<Api.countryItem>) => {  
  <ReactSelect
    value
    // onChange={this.handleChange}
    options
  />

}