import Testing
@testable import PointerKit

struct UtilitiesTests {}

extension UtilitiesTests {
  @Test func copyAsSourceElement() {
    var destinationValue: Int64 = 0x12345678
    let sourceValue: UInt8 = 0x12

    copy(
      fromValue: sourceValue,
      toValue: &destinationValue,
      as: .sourceElement,
    )

    #expect(destinationValue == 0x12345612)
  }

  @Test func copyAsDestinationElement() {
    var destinationValue: UInt8 = 0x56
    let sourceValue: Int64 = 0x1234

    copy(
      fromValue: sourceValue,
      toValue: &destinationValue,
      as: .destinationElement,
    )

    #expect(destinationValue == 0x34)
  }

  @Test func copyAsExplicitType() {
    var destinationValue: UInt64 = 0
    let sourceValue: UInt64 = 0x12345678

    copy(
      fromValue: sourceValue,
      toValue: &destinationValue,
      as: UInt16.self,
    )

    #expect(destinationValue == 0x5678)
  }

  @Test func copyWithMultipleExplicitElements() {
    var destinationValue: UInt32 = 0x12345678
    let sourceValue: UInt32 = 0

    copy(
      fromValue: sourceValue,
      toValue: &destinationValue,
      as: UInt8.self,
      count: 3,
    )

    #expect(destinationValue == 0x12000000)
  }

  @Test func copyByteCount() {
    var destinationValue = 0
    let sourceValue = 0x12345678

    copy(
      fromValue: sourceValue,
      toValue: &destinationValue,
      byteCount: 4,
    )

    #expect(destinationValue == 0x12345678)
  }
}
