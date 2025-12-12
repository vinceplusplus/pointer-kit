extension Buffer: Collection {
  public var startIndex: Int { 0 }
  public var endIndex: Int { count }

  public func index(after i: Int) -> Int {
    i + 1
  }

  public subscript (position: Int) -> T {
    get {
      native()[position]
    }
    nonmutating set {
      mutableNative()[position] = newValue
    }
  }
}

