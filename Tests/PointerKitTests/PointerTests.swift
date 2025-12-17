import Testing
@testable import PointerKit

@Suite
struct PointerTests {
  @Test func pointee() {
    var value = 42

    withUnsafePointer(to: &value) {
      let pointer = Pointer<Int>(address: Int(bitPattern: $0))

      #expect(pointer.pointee == 42)
    }
  }

  @Test func isNil() {
    #expect(Pointer<UInt8>(0).isNil == true)
    #expect(Pointer<UInt8>(0x1234).isNil == false)
  }
}

