// ReactDOM.render(
//   <React.StrictMode> <App /> </React.StrictMode>,
//   ReactDOM.querySelector("#root")->Belt.Option.getExn,
// )
switch(ReactDOM.querySelector("#root")){
| Some(root) => ReactDOM.render(<React.StrictMode> <App /> </React.StrictMode>, root)
| None => () // do nothing
}