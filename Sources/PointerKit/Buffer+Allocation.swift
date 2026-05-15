public extension Buffer {
  static func allocate(
    count: Int,
    alignment: Int = MemoryLayout<T>.alignment,
  ) -> Buffer<T> {
    .init(UnsafeMutableRawBufferPointer.allocate(
      byteCount: count * MemoryLayout<T>.stride,
      alignment: alignment,
    ))
  }

  func deallocate() {
    self.nativeMutableRaw().deallocate()
  }
}

