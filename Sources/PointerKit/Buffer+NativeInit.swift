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
  // NOTE: can take UnsafePointer<T>, UnsafeMutablePointer<T>, UnsafeMutableRawPointer as well
  init(_ start: UnsafeRawPointer, _ count: Int) {
    self.init(
      start: .init(start),
      count: count
    )
  }
}

