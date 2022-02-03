module Styles = {
  open Emotion

  let list = css({
    "border": "1px solid #d9dddd",
    "&:hover": {
      "cursor": "pointer",
    },
  })

  let listItem = css({
    "display": "flex",
    "alignItems": "center",
    "justifyContent": "flex-start",
  })
}

module Row = {
  @react.component
  let make = (~style: ReactDOM.style, ~index: int, ~children: React.element) =>
    <div style={style} key={Js.Int.toString(index)} className={Styles.listItem}> children </div>
}

@react.component
let make = (~height: int, ~itemSize: int, ~menuProps: ReactSelect.menuListProps) => {
  <ReactWindow
    height
    itemSize
    itemCount={React.Children.toArray(menuProps.children)->Js.Array2.length}
    className={Styles.list}>
    {({style, index}) =>
      <Row style index> {React.Children.toArray(menuProps.children)[index]} </Row>}
  </ReactWindow>
}
