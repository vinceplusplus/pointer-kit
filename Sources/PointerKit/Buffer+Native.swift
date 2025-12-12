public extension Buffer {
  func native() -> UnsafeBufferPointer<T> {
    unsafeBitCast(self, to: UnsafeBufferPointer<T>.self)
  }
  func mutableNative() -> UnsafeMutableBufferPointer<T> {
    unsafeBitCast(self, to: UnsafeMutableBufferPointer<T>.self)
  }
}

