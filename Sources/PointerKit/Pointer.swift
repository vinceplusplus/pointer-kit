public struct Pointer<T>: Hashable, Sendable {
  public var address: Int
}

public extension Pointer {
  var pointee: T {
    get { native().pointee }
    nonmutating set { nativeMutable().pointee = newValue }
  }

  var isNil: Bool {
    get { address == 0 }
  }
}

