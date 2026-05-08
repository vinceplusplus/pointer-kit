public extension Pointer {
  subscript (position: Int) -> T {
    get {
      native()[position]
    }
    nonmutating set {
      nativeMutable()[position] = newValue
    }
  }
}

