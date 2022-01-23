type countryItem = {
  value: string, 
  label: string}
type countries = array<countryItem>


module Decode = {
  let countryData = json =>
    Json.Decode.{
      value: json => field("value", string),
      label: json => field("label", string)
    }
}

