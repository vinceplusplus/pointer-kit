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

  @Test func nativeRaw() {
    let value = 0x12345678

    withPointer(value) { pointer in
      let unsafeRawPointer = pointer.nativeRaw()

      #expect(unsafeRawPointer.load(as: Int.self) == 0x12345678)
    }
  }

  @Test func nativeMutable() {
    var value = 42

    withPointer(&value) { pointer in
      let unsafePointer = pointer.nativeMutable()

      #expect(unsafePointer.pointee == 42)

      unsafePointer.pointee += 10
    }

    #expect(value == 52)
  }

  @Test func nativeMutableRaw() {
    var value = 0x13572468

    withPointer(&value) { pointer in
      let unsafeRawPointer = pointer.nativeMutableRaw()

      #expect(unsafeRawPointer.load(as: Int.self) == 0x13572468)

      pointer.pointee += 0x10

      #expect(unsafeRawPointer.load(as: Int.self) == 0x13572478)

      unsafeRawPointer.storeBytes(of: 0x24681357, as: Int.self)
    }

    #expect(value == 0x24681357)
  }
}

