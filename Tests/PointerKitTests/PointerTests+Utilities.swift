import Testing
@testable import PointerKit

extension PointerTests {
  @Test func withPointerWithImmutableValue() {
    withPointer(42 as Int) {
      #expect($0.pointee == 42)
    }
  }

  @Test func withPointerWithMutableValue() {
    var value = 42

    withPointer(&value) {
      #expect($0.pointee == 42)

      $0.pointee += 10

      #expect($0.pointee == 52)
    }

    #expect(value == 52)
  }

  @Test func withPointerWithImmutableValueAndTargetType() {
    withPointer(0x1234 as Int64, UInt8.self) { pointer in
      #expect(pointer[0] == 0x34)
      #expect(pointer[1] == 0x12)
    }
  }

  @Test func withPointerWithMutableValueAndTargetType() {
    var value = 0x1234

    withPointer(&value, UInt8.self) { pointer in
      #expect(pointer[0] == 0x34)
      #expect(pointer[1] == 0x12)

      pointer[0] += 0x10
      pointer[1] += 0x10

      #expect(pointer[0] == 0x44)
      #expect(pointer[1] == 0x22)
    }

    #expect(value == 0x2244)
  }
}

