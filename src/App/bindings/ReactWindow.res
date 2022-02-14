type childrenFnProps = {
  index: int,
  style: ReactDOM.style,
}

type childrenFn = childrenFnProps => React.element

type listRefProps = {itemData: Js.Nullable.t<Api.countryItem>}

type listRef = {
  scrollToItem: (. int, string) => unit,
  props: listRefProps,
}

@module("react-window") @react.component
external make: (
  ~height: int,
  ~itemSize: int,
  ~itemCount: int,
  ~children: childrenFn,
  ~className: string=?,
  ~itemData: Js.Nullable.t<Api.countryItem>,
  ~ref: React.ref<Js.Nullable.t<listRef>>,
  ~initialScrollOffset: int,
) => React.element = "FixedSizeList"
