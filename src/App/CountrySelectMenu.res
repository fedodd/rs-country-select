module Styles = {
  open Emotion

  let list = css({
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
  let make = (~style: ReactDOM.style, ~children: React.element) =>
    <div style={style} className={Styles.listItem}> children </div>
}

@react.component
let make = (
  ~height: int,
  ~itemSize: int,
  ~menuProps: ReactSelect.menuListProps,
  ~listRef: React.ref<Js.Nullable.t<ReactWindow.listRef>>,
) => {
  let childrenArray = React.Children.toArray(menuProps.children)

  let value = menuProps.getValue()
  <ReactWindow
    height
    itemSize
    itemCount={Js.Array2.length(childrenArray)}
    className={Styles.list}
    itemData={menuProps.focusedOption}
    ref={listRef}
    initialScrollOffset={switch Js.Nullable.toOption(value) {
    | Some(targetOption) => {
        Js.log(targetOption)
        let index = Js.Array2.findIndex(menuProps.options, option =>
          option.value === targetOption[0].value
        )
        switch index {
        | 0 => 0
        | value => value * 26
        }
      }
    | None => 0
    }}>
    {({style, index}) => <Row style key={Js.Int.toString(index)}> {childrenArray[index]} </Row>}
  </ReactWindow>
}
