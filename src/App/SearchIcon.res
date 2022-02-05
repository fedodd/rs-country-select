module SearchIcon = {
  @module("./assets/search_icon.svg") @react.component
  external make: (~className: string) => React.element = "ReactComponent"
}

module Styles = {
  open Emotion

  let searchIcon = css({
    "height": 13,
    "width": 13,
  })
}

@react.component
let make = () => <div> <SearchIcon className={Styles.searchIcon} /> </div>
