public func withPointer<T, Result>(
  _ value: T,
  _ body: (Pointer<T>) throws -> Result,
) rethrows -> Result {
  try withPointer(value, T.self, body)
}

public func withPointer<T, Result>(
  _ value: inout T,
  _ body: (Pointer<T>) throws -> Result,
) rethrows -> Result {
  try withPointer(&value, T.self, body)
}

public func withPointer<S, T, Result>(
  _ value: S,
  _ type: T.Type,
  _ body: (Pointer<T>) throws -> Result,
) rethrows -> Result {
  try withUnsafePointer(to: value) {
    try body(unsafeBitCast($0, to: Pointer<T>.self))
  }
}

public func withPointer<S, T, Result>(
  _ value: inout S,
  _ type: T.Type,
  _ body: (Pointer<T>) throws -> Result,
) rethrows -> Result {
  try withUnsafePointer(to: &value) {
    try body(unsafeBitCast($0, to: Pointer<T>.self))
  }
}

