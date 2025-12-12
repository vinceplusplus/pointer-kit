public extension Pointer {
  func native() -> UnsafePointer<T> {
    unsafeBitCast(self, to: UnsafePointer<T>.self)
  }
  func mutableNative() -> UnsafeMutablePointer<T> {
    unsafeBitCast(self, to: UnsafeMutablePointer<T>.self)
  }
}

