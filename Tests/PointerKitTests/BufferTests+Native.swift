import Testing
@testable import PointerKit

extension BufferTests {
  @Test func native() {
    withBuffer(array: [1, 2, 3, 4, 5]) { buffer in
      let unsafeBuffer = buffer.native()

      #expect(unsafeBuffer.count == 5)
      #expect(unsafeBuffer[0] == 1)
      #expect(unsafeBuffer[1] == 2)
      #expect(unsafeBuffer[2] == 3)
      #expect(unsafeBuffer[3] == 4)
      #expect(unsafeBuffer[4] == 5)
    }
  }

  @Test func nativeRaw() {
    withBuffer(array: [0x1234]) { buffer in
      let unsafeRawBuffer = buffer.nativeRaw()

      #expect(unsafeRawBuffer.count == 8)
      #expect(unsafeRawBuffer[0] == 0x34)
      #expect(unsafeRawBuffer[1] == 0x12)
      #expect(unsafeRawBuffer[2] == 0)
      #expect(unsafeRawBuffer[3] == 0)
      #expect(unsafeRawBuffer[4] == 0)
      #expect(unsafeRawBuffer[5] == 0)
      #expect(unsafeRawBuffer[6] == 0)
      #expect(unsafeRawBuffer[7] == 0)
    }
  }

  @Test func nativeMutable() {
    var array = [1, 2, 3, 4, 5]

    withBuffer(array: &array) { buffer in
      let unsafeBuffer = buffer.nativeMutable()

      #expect(unsafeBuffer.count == 5)
      #expect(unsafeBuffer[0] == 1)
      #expect(unsafeBuffer[1] == 2)
      #expect(unsafeBuffer[2] == 3)
      #expect(unsafeBuffer[3] == 4)
      #expect(unsafeBuffer[4] == 5)

      buffer[0] += 1
      buffer[1] += 2
      buffer[2] += 3
      buffer[3] += 4
      buffer[4] += 5

      #expect(unsafeBuffer[0] == 2)
      #expect(unsafeBuffer[1] == 4)
      #expect(unsafeBuffer[2] == 6)
      #expect(unsafeBuffer[3] == 8)
      #expect(unsafeBuffer[4] == 10)
    }

    #expect(array[0] == 2)
    #expect(array[1] == 4)
    #expect(array[2] == 6)
    #expect(array[3] == 8)
    #expect(array[4] == 10)
  }

  @Test func nativeMutableRaw() {
    var array = [0x5678]

    withBuffer(array: &array) { buffer in
      let unsafeRawBuffer = buffer.nativeMutableRaw()

      #expect(unsafeRawBuffer.count == 8)
      #expect(unsafeRawBuffer[0] == 0x78)
      #expect(unsafeRawBuffer[1] == 0x56)
      #expect(unsafeRawBuffer[2] == 0)
      #expect(unsafeRawBuffer[3] == 0)
      #expect(unsafeRawBuffer[4] == 0)
      #expect(unsafeRawBuffer[5] == 0)
      #expect(unsafeRawBuffer[6] == 0)
      #expect(unsafeRawBuffer[7] == 0)

      buffer[0] += 1

      #expect(unsafeRawBuffer[0] == 0x79)
      #expect(unsafeRawBuffer[1] == 0x56)
      #expect(unsafeRawBuffer[2] == 0)
      #expect(unsafeRawBuffer[3] == 0)
      #expect(unsafeRawBuffer[4] == 0)
      #expect(unsafeRawBuffer[5] == 0)
      #expect(unsafeRawBuffer[6] == 0)
      #expect(unsafeRawBuffer[7] == 0)
    }

    #expect(array[0] == 0x5679)
  }
}

