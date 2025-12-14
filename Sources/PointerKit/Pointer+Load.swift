public extension Pointer {
  func loadElement<S>(_ type: S.Type) -> S {
    Pointer<S>(self).pointee
  }

  func loadArray<S>(_ type: S.Type, _ count: Int) -> Buffer<S> {
    .init(start: .init(self), count: count)
  }
}

