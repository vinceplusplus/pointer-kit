public extension Pointer {
  func loadElement<S>(_ type: S.Type) -> S {
    Pointer<S>(self).pointee
  }

  func loadArray<S>(_ type: S.Type, _ count: Int) -> Buffer<S> {
    .init(Pointer<T>.init(self), count)
  }
}

