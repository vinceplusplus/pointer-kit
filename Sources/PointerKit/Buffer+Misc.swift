public extension Buffer {
  static func zeros<Result>(
    _ count: Int,
    _ body: (Buffer<T>) throws -> Result,
  ) rethrows -> Result {
    try withBuffer(array: [UInt8](
      repeating: 0,
      count: MemoryLayout<T>.stride * count,
    )) {
      try body(.init($0))
    }
  }
}

