public extension Pointer {
  func native() -> UnsafePointer<T> {
    unsafeBitCast(self, to: UnsafePointer<T>.self)
  }

  func nativeRaw() -> UnsafeRawPointer {
    unsafeBitCast(self, to: UnsafeRawPointer.self)
  }

  func nativeMutable() -> UnsafeMutablePointer<T> {
    unsafeBitCast(self, to: UnsafeMutablePointer<T>.self)
  }

  func nativeMutableRaw() -> UnsafeMutableRawPointer {
    unsafeBitCast(self, to: UnsafeMutableRawPointer.self)
  }
}

