@react.component

 
// @scope("JSON") @val

let make = () => {
  let greetings = React.string("Hello World!!!")

  let (countrySelects: array<Types.countryItem>, setCountrySelects) = React.useState(_ => [])
  let (state: string, setState) = React.useState(_ => "")
  

  React.useEffect0(() => {
    
    let apiUrl = " https://gist.githubusercontent.com/rusty-key/659db3f4566df459bd59c8a53dc9f71f/raw/4127f9550ef063121c564025f6d27dceeb279623/counties.json"

    

    let _ =
      Fetch.fetch(apiUrl)
      ->Js.Promise.then_(Fetch.Response.json, _)
      ->Js.Promise.then_(json => {
        let arr = Js.Json.decodeArray(json);
        switch arr {
        | None => setState(_prev => "error")
        | _arr => setState(_prev => "sucess")
        }

        
        // let parsedArr = Js.Json.decodeArray(json)
        // setCountrySelects(_prev => arr)
        
        Js.log(arr)
        Js.Promise.resolve()
      }, _)
        // ->Js.Promise.catch(_ => {
        // Js.Promise.resolve()}, _)
        


    None 
  })


  <div>
    <p>greetings</p>
    <p>{React.string(state)}</p>
    // <ul>Js.Array2.map(state, elem => React.string(elem.label))</ul>
  </div>
}