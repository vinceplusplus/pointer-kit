public struct Pointer<T>: Hashable {
  public var address: Int
}

public extension Pointer {
  var pointee: T {
    get { native().pointee }
    nonmutating set { mutableNative().pointee = newValue }
  }

  var isNil: Bool {
    get { address == 0 }
  }
}

