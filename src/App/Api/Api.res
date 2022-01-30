type countryItem = {
  value: string,
  label: string,
}

module Response = {
  type t<'data>
  @send external json: t<'data> => Promise.t<'data> = "json"
}

module Country = {
  type t = {id: int, name: string}

  @val @scope("globalThis")
  external fetch: string => Promise.t<Response.t<Js.Nullable.t<array<countryItem>>>> = "fetch"
  @val @scope("globalThis")
  let getCountries = () => {
    open Promise
    let apiUrl = " https://gist.githubusercontent.com/rusty-key/659db3f4566df459bd59c8a53dc9f71f/raw/4127f9550ef063121c564025f6d27dceeb279623/counties.json"

    fetch(apiUrl)
    ->then(res => {
      res->Response.json
    })
    ->then(data => {
      let ret = switch Js.Nullable.toOption(data) {
      | Some(data) => data
      | None => []
      }
      Ok(ret)->resolve
    })
    ->catch(e => {
      let msg = switch e {
      | JsError(err) =>
        switch Js.Exn.message(err) {
        | Some(msg) => msg
        | None => ""
        }
      | _ => "Unexpected error occurred"
      }
      Error(msg)->resolve
    })
  }
}

exception FailedRequest(string)
