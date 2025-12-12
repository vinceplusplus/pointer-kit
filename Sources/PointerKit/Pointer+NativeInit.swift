public extension Pointer {
  // NOTE: can take UnsafePointer<T>, UnsafeMutablePointer<T>, UnsafeMutableRawPointer as well
  init(_ pointer: UnsafeRawPointer) {
    self.init(Int(bitPattern: pointer))
  }
}

