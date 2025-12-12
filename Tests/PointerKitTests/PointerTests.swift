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
}

