public extension Buffer {
  init<S>(_ buffer: Buffer<S>) {
    self.init(
      start: buffer.start,
      count: MemoryLayout<S>.stride * buffer.count / MemoryLayout<T>.stride
    )
  }
}

public extension Buffer {
  init<S>(source: Pointer<S>, sourceCount: Int) {
    self.init(
      start: .init(source),
      count: MemoryLayout<S>.stride * sourceCount / MemoryLayout<T>.stride
    )
  }

  init<S>(start: Pointer<S>, count: Int) {
    self.init(
      start: .init(start),
      count: count
    )
  }
}

