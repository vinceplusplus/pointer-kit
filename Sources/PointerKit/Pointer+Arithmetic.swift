public extension Pointer {
  static func + (lhs: Self, rhs: Int) -> Self {
    .init(lhs.address + MemoryLayout<T>.stride * rhs)
  }

  static func - (lhs: Self, rhs: Int) -> Self {
    .init(lhs.address - MemoryLayout<T>.stride * rhs)
  }

  static func += (lhs: inout Self, rhs: Int) {
    lhs = lhs + rhs
  }

  static func -= (lhs: inout Self, rhs: Int) {
    lhs = lhs - rhs
  }
}

public extension Pointer {
  static func - (lhs: Self, rhs: Self) -> Int {
    (lhs.address - rhs.address) / MemoryLayout<T>.stride
  }
}

