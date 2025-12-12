public extension Buffer where T: BinaryInteger {
  static func zeros<Result>(_ count: Int, _ body: (Buffer<T>) throws -> Result) rethrows -> Result {
    try [T](repeating: 0, count: count).withUnsafeBytes {
      try body(.init($0))
    }
  }
}

