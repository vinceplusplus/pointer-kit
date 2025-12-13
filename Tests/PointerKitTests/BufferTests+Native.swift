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

  @Test func mutableNative() {
    var array = [1, 2, 3, 4, 5]
    withBuffer(array: &array) { buffer in
      let unsafeBuffer = buffer.mutableNative()

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
}

