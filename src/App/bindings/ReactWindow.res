type childrenFnProps = {
  index: int,
  style: ReactDOM.style,
}

type childrenFn = childrenFnProps => React.element

@module("react-window") @react.component
external make: (
  ~height: int,
  ~itemSize: int,
  ~itemCount: int,
  ~children: childrenFn,
  ~className: string=?,
) => React.element = "FixedSizeList"
