public func withBuffer<T, Result>(
  _ array: [T],
  _ body: (Buffer<T>) throws -> Result,
) rethrows -> Result {
  try array.withUnsafeBufferPointer {
    try body(.init($0))
  }
}

public func withBuffer<T, Result>(
  _ array: inout [T],
  _ body: (Buffer<T>) throws -> Result,
) rethrows -> Result {
  try array.withUnsafeBufferPointer {
    try body(.init($0))
  }
}

