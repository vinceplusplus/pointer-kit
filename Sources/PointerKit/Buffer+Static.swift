public extension Buffer {
  static var `nil`: Buffer<T> { .init(start: Pointer<T>(0), count: 0) }
}

