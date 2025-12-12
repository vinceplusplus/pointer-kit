public extension Buffer {
  init<S>(_ start: Pointer<S>, _ count: Int) {
    self.init(
      start: .init(start),
      count: count
    )
  }

  init<S>(_ buffer: Buffer<S>) {
    self.init(
      buffer.start,
      MemoryLayout<S>.stride * buffer.count / MemoryLayout<T>.stride
    )
  }
}

