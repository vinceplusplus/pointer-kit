public extension Pointer {
  init(_ address: Int) {
    self.address = address
  }
}

public extension Pointer {
  init<S>(_ pointer: Pointer<S>) {
    self.init(pointer.address)
  }
}

