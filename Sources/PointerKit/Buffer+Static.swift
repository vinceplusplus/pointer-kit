public extension Buffer {
  static var `nil`: Buffer<T> { .init(start: Pointer<Int>(0), count: 0) }
}

