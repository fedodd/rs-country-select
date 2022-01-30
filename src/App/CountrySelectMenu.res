module Styles = {
  open Emotion

  let list = css({
    "border": "1px solid #d9dddd",
  })

  let listItem = css({
    "display": "flex",
    "alignItems": "center",
    "justifyContent": "flexStart",
  })
}

module Row = {
  @react.component
  let make = (~style: ReactDOM.style, ~index: int, ~children: React.element) =>
    <div style={style} className={Styles.listItem}>
      children
    </div>
}

@react.component
let make = (~height: int, ~itemSize: int, ~menuProps: ReactSelect.menuListProps) =>
  <ReactWindow
    height itemSize itemCount={Js.Array2.length(menuProps.options)} className={Styles.list}>
    {({style, index}) => <Row style index >{React.Children.toArray(menuProps.children)[index]}</Row>}
  </ReactWindow>
