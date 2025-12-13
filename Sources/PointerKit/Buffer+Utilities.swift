public func withBuffer<T, Result>(
  element: T,
  _ body: (Buffer<UInt8>) throws -> Result,
) rethrows -> Result {
  try withUnsafeBytes(of: element) {
    try body(.init($0))
  }
}

public func withBuffer<T, Result>(
  element: inout T,
  _ body: (Buffer<UInt8>) throws -> Result,
) rethrows -> Result {
  try withUnsafeMutableBytes(of: &element) {
    try body(.init($0))
  }
}

public func withBuffer<T, Result>(
  array: [T],
  _ body: (Buffer<T>) throws -> Result,
) rethrows -> Result {
  try array.withUnsafeBufferPointer {
    try body(.init($0))
  }
}

public func withBuffer<T, Result>(
  array: inout [T],
  _ body: (Buffer<T>) throws -> Result,
) rethrows -> Result {
  try array.withUnsafeMutableBufferPointer {
    try body(.init($0))
  }
}

