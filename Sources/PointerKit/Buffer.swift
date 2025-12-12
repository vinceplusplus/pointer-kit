public struct Buffer<T>: Hashable {
  public let start: Pointer<T>
  public let count: Int
}

