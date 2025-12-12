import Testing
@testable import PointerKit

extension PointerTests {
  @Test func unsafePointer() {
    withUnsafePointer(to: 42) { pointer1 in
      let pointer2 = Pointer<Int>(pointer1)

      #expect(pointer2.pointee == 42)
    }
  }

  @Test func unsafeMutablePointer() {
    var value = 42

    withUnsafeMutablePointer(to: &value) { pointer1 in
      let pointer2 = Pointer<Int>(pointer1)

      #expect(pointer2.pointee == 42)

      pointer2.pointee += 10
    }

    #expect(value == 52)
  }

  @Test func unsafeRawPointer() {
    var value = 42

    withUnsafeBytes(of: &value) { pointer1 in
      let pointer2 = Pointer<Int>(pointer1.baseAddress!)

      #expect(pointer2.pointee == 42)
    }
  }

  @Test func unsafeMutableRawPointer() {
    var value = 42

    withUnsafeMutableBytes(of: &value) { pointer1 in
      let pointer2 = Pointer<Int>(pointer1.baseAddress!)

      #expect(pointer2.pointee == 42)
    }
  }
}

