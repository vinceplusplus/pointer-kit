import Testing
@testable import PointerKit

extension PointerTests {
  @Test func copyFromValueAsSourceElement() {
    var destination: Int64 = 0x12345678
    let source: UInt8 = 0x12

    withPointer(&destination) { destinationPointer in
      destinationPointer.copy(fromValue: source, as: .sourceElement)
    }

    #expect(destination == 0x12345612)
  }

  @Test func copyFromValueAsDestinationElement() {
    var destination: UInt8 = 0x56
    let source: Int64 = 0x1234

    withPointer(&destination) { destinationPointer in
      destinationPointer.copy(fromValue: source, as: .destinationElement)
    }

    #expect(destination == 0x34)
  }

  @Test func copyFromValueAsExplicitType() {
    var destination: UInt64 = 0
    let source: UInt64 = 0x12345678

    withPointer(&destination) { destinationPointer in
      destinationPointer.copy(fromValue: source, as: UInt16.self)
    }

    #expect(destination == 0x5678)
  }

  @Test func copyFromValueWithMultipleDestinationElements() {
    var destination: UInt32 = 0
    let source: UInt32 = 0x12345678

    withPointer(&destination, UInt8.self) { destinationPointer in
      destinationPointer.copy(fromValue: source, as: .destinationElement, count: 2)
    }

    #expect(destination == 0x5678)
  }

  @Test func copyFromValueWithMultipleExplicitElements() {
    var destination: UInt32 = 0x12345678
    let source: UInt32 = 0

    withPointer(&destination) { destinationPointer in
      destinationPointer.copy(fromValue: source, as: UInt8.self, count: 3)
    }

    #expect(destination == 0x12000000)
  }

  @Test func copyFromValueByteCount() {
    var destination: Int = 0
    let source: Int = 0x12345678

    withPointer(&destination) { destinationPointer in
      destinationPointer.copy(fromValue: source, byteCount: 4)
    }

    #expect(destination == 0x12345678)
  }
}
