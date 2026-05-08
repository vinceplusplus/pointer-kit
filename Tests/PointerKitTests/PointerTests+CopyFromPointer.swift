import Testing
@testable import PointerKit

extension PointerTests {
  @Test func copyFromPointerAsSourceElement() {
    var source: UInt8 = 0x12
    var destination: Int64 = 0x12345678

    withPointer(&destination) { destinationPointer in
      withPointer(&source) { sourcePointer in
        destinationPointer.copy(fromPointer: sourcePointer, as: .sourceElement)
      }
    }

    #expect(destination == 0x12345612)
  }

  @Test func copyFromPointerAsDestinationElement() {
    var source: Int64 = 0x1234
    var destination: UInt8 = 0x56

    withPointer(&destination) { destinationPointer in
      withPointer(&source) { sourcePointer in
        destinationPointer.copy(fromPointer: sourcePointer, as: .destinationElement)
      }
    }

    #expect(destination == 0x34)
  }

  @Test func copyFromPointerAsExplicitType() {
    var source: UInt64 = 0x12345678
    var destination: UInt64 = 0

    withPointer(&destination) { destinationPointer in
      withPointer(&source) { sourcePointer in
        destinationPointer.copy(fromPointer: sourcePointer, as: UInt16.self)
      }
    }

    #expect(destination == 0x5678)
  }

  @Test func copyFromPointerWithMultipleSourceElements() {
    var source: UInt32 = 0x12345678
    var destination: UInt32 = 0

    withPointer(&source, UInt8.self) { sourcePointer in
      withPointer(&destination) { destinationPointer in
        destinationPointer.copy(fromPointer: sourcePointer, as: .sourceElement, count: 3)
      }
    }

    #expect(destination == 0x345678)
  }

  @Test func copyFromPointerWithMultipleDestinationElements() {
    var source: UInt32 = 0x12345678
    var destination: UInt32 = 0

    withPointer(&source) { sourcePointer in
      withPointer(&destination, UInt8.self) { destinationPointer in
        destinationPointer.copy(fromPointer: sourcePointer, as: .destinationElement, count: 2)
      }
    }

    #expect(destination == 0x5678)
  }

  @Test func copyFromPointerWithMultipleExplicitElements() {
    var source = 0x12345678
    var destination = 0

    withPointer(&source) { sourcePointer in
      withPointer(&destination) { destinationPointer in
        destinationPointer.copy(fromPointer: sourcePointer, as: UInt8.self, count: 3)
      }
    }

    #expect(destination == 0x345678)
  }

  @Test func copyFromPointerByteCount() {
    var source = 0x12345678
    var destination = 0

    withPointer(&source) { sourcePointer in
      withPointer(&destination) { destinationPointer in
        destinationPointer.copy(fromPointer: sourcePointer, byteCount: 4)
      }
    }

    #expect(destination == 0x12345678)
  }
}
