public extension Buffer {
  init(_ bufferPointer: UnsafeBufferPointer<T>) {
    let (start, count) = unsafeBitCast(bufferPointer, to: (Int, Int).self)

    self.init(
      start: .init(start),
      count: count
    )
  }

  init(_ bufferPointer: UnsafeMutableBufferPointer<T>) {
    let (start, count) = unsafeBitCast(bufferPointer, to: (Int, Int).self)

    self.init(
      start: .init(start),
      count: count
    )
  }

  init(_ bufferPointer: UnsafeRawBufferPointer) {
    let (start, end) = unsafeBitCast(bufferPointer, to: (Int, Int).self)

    self.init(
      start: .init(start),
      count: (end - start) / MemoryLayout<T>.stride
    )
  }

  init(_ bufferPointer: UnsafeMutableRawBufferPointer) {
    let (start, end) = unsafeBitCast(bufferPointer, to: (Int, Int).self)

    self.init(
      start: .init(start),
      count: (end - start) / MemoryLayout<T>.stride
    )
  }
}

public extension Buffer {
  init<S>(_ bufferPointer: UnsafeBufferPointer<S>) {
    let (start, count) = unsafeBitCast(bufferPointer, to: (Int, Int).self)

    self.init(
      start: .init(start),
      count: MemoryLayout<S>.stride * count / MemoryLayout<T>.stride
    )
  }

  init<S>(_ bufferPointer: UnsafeMutableBufferPointer<S>) {
    let (start, count) = unsafeBitCast(bufferPointer, to: (Int, Int).self)

    self.init(
      start: .init(start),
      count: MemoryLayout<S>.stride * count / MemoryLayout<T>.stride
    )
  }
}

public extension Buffer {
  // NOTE: can also take UnsafeMutableRawPointer
  init(bytes: UnsafeRawPointer, byteCount: Int) {
    self.init(
      start: .init(bytes),
      count: byteCount / MemoryLayout<T>.stride,
    )
  }

  // NOTE: can also take UnsafeMutablePointer<S>
  init<S>(source: UnsafePointer<S>, sourceCount: Int) {
    self.init(
      start: .init(source),
      count: MemoryLayout<S>.stride * sourceCount / MemoryLayout<T>.stride,
    )
  }

  // NOTE: can also take UnsafeMutablePointer<S>
  init<S>(start: UnsafePointer<S>, count: Int) {
    self.init(
      start: .init(start),
      count: count,
    )
  }
}

