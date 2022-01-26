  @react.component
  let make = (~option: Api.countryItem) => {
    <div>
      <span className={"fi fi-" ++ option.value}></span> {React.string(option.label)}
    </div>
  }