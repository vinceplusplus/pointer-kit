public struct Buffer<T>: Hashable, Sendable {
  public let start: Pointer<T>
  public let count: Int
}

public extension Buffer {
  var isNil: Bool {
    get { start.isNil }
  }
}

