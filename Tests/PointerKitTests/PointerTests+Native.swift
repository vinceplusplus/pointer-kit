import Testing
@testable import PointerKit

extension PointerTests {
  @Test func native() {
    let value = 42

    withPointer(value) { pointer in
      let unsafePointer = pointer.native()

      #expect(unsafePointer.pointee == 42)
    }
  }

  @Test func mutableNative() {
    var value = 42

    withPointer(&value) { pointer in
      let unsafePointer = pointer.mutableNative()

      #expect(unsafePointer.pointee == 42)

      unsafePointer.pointee += 10
    }

    #expect(value == 52)
  }
}

