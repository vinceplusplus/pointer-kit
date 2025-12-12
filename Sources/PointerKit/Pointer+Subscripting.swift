public extension Pointer {
  subscript (position: Int) -> T {
    get {
      native()[position]
    }
    nonmutating set {
      mutableNative()[position] = newValue
    }
  }
}

