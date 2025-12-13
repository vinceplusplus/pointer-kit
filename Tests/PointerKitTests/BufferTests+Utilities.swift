import Testing
@testable import PointerKit

extension BufferTests {
  @Test func withBufferWithImmutableElement() {
    withBuffer(element: 0x1234567813572468) { buffer in
      #expect(buffer.count == 8)
      #expect(buffer[0] == 0x68)
      #expect(buffer[1] == 0x24)
      #expect(buffer[2] == 0x57)
      #expect(buffer[3] == 0x13)
      #expect(buffer[4] == 0x78)
      #expect(buffer[5] == 0x56)
      #expect(buffer[6] == 0x34)
      #expect(buffer[7] == 0x12)
    }
  }

  @Test func withBufferWithMutableElement() {
    var value = 0x1234567813572468 as Int64

    withBuffer(element: &value) { buffer in
      #expect(buffer.count == 8)
      #expect(buffer[0] == 0x68)
      #expect(buffer[1] == 0x24)
      #expect(buffer[2] == 0x57)
      #expect(buffer[3] == 0x13)
      #expect(buffer[4] == 0x78)
      #expect(buffer[5] == 0x56)
      #expect(buffer[6] == 0x34)
      #expect(buffer[7] == 0x12)

      buffer[0] += 1
      buffer[1] += 1
      buffer[2] += 1
      buffer[3] += 1
      buffer[4] += 1
      buffer[5] += 1
      buffer[6] += 1
      buffer[7] += 1

      #expect(buffer[0] == 0x69)
      #expect(buffer[1] == 0x25)
      #expect(buffer[2] == 0x58)
      #expect(buffer[3] == 0x14)
      #expect(buffer[4] == 0x79)
      #expect(buffer[5] == 0x57)
      #expect(buffer[6] == 0x35)
      #expect(buffer[7] == 0x13)
    }

    #expect(value == 0x1335577914582569)
  }

  @Test func withBufferWithImmutableArray() {
    withBuffer(array: [1, 2, 3, 4, 5]) { buffer in
      #expect(buffer.count == 5)
      #expect(buffer[0] == 1)
      #expect(buffer[1] == 2)
      #expect(buffer[2] == 3)
      #expect(buffer[3] == 4)
      #expect(buffer[4] == 5)
    }
  }

  @Test func withBufferWithMutableArray() {
    var array = [1, 2, 3, 4, 5]

    withBuffer(array: &array) { buffer in
      #expect(buffer.count == 5)
      #expect(buffer[0] == 1)
      #expect(buffer[1] == 2)
      #expect(buffer[2] == 3)
      #expect(buffer[3] == 4)
      #expect(buffer[4] == 5)

      buffer[0] += 1
      buffer[1] += 2
      buffer[2] += 3
      buffer[3] += 4
      buffer[4] += 5

      #expect(buffer[0] == 2)
      #expect(buffer[1] == 4)
      #expect(buffer[2] == 6)
      #expect(buffer[3] == 8)
      #expect(buffer[4] == 10)
    }

    #expect(array == [2, 4, 6, 8, 10])
  }
}

