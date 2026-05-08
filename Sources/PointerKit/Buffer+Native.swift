public extension Buffer {
  func native() -> UnsafeBufferPointer<T> {
    unsafeBitCast(self, to: UnsafeBufferPointer<T>.self)
  }

  func nativeRaw() -> UnsafeRawBufferPointer {
    .init(native())
  }

  func nativeMutable() -> UnsafeMutableBufferPointer<T> {
    unsafeBitCast(self, to: UnsafeMutableBufferPointer<T>.self)
  }

  func nativeMutableRaw() -> UnsafeMutableRawBufferPointer {
    .init(nativeMutable())
  }
}

