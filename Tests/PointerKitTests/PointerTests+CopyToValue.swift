import Testing
@testable import PointerKit

extension PointerTests {
  @Test func copyToValueAsSourceElement() {
    var value: Int64 = 0
    let source: UInt8 = 0x12

    withPointer(source) { sourcePointer in
      sourcePointer.copy(toValue: &value, as: .sourceElement)
    }

    #expect(value == 0x12)
  }

  @Test func copyToValueAsDestinationElement() {
    var value: UInt8 = 0
    let source: Int64 = 0x12345678

    withPointer(source) { sourcePointer in
      sourcePointer.copy(toValue: &value, as: .destinationElement)
    }

    #expect(value == 0x78)
  }

  @Test func copyToValueAsExplicitType() {
    var value: UInt64 = 0
    let source: Int64 = 0x12345678

    withPointer(source) { sourcePointer in
      sourcePointer.copy(toValue: &value, as: UInt16.self)
    }

    #expect(value == 0x5678)
  }

  @Test func copyToValueWithMultipleSourceElements() {
    var value: UInt32 = 0
    var source: UInt32 = 0x12345678

    withPointer(&source, UInt8.self) { sourcePointer in
      sourcePointer.copy(toValue: &value, as: .sourceElement, count: 3)
    }

    #expect(value == 0x345678)
  }

  @Test func copyToValueWithMultipleExplicitElements() {
    var value = 0
    let source = 0x12345678

    withPointer(source) { sourcePointer in
      sourcePointer.copy(toValue: &value, as: UInt8.self, count: 3)
    }

    #expect(value == 0x345678)
  }

  @Test func copyToValueByteCount() {
    var value = 0
    let source = 0x12345678

    withPointer(source) { sourcePointer in
      sourcePointer.copy(toValue: &value, byteCount: 4)
    }

    #expect(value == 0x12345678)
  }
}
