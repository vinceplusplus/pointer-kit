import Testing
@testable import PointerKit

extension BufferTests {
  @Test func withBufferWithImmutableArray() {
    withBuffer([1, 2, 3, 4, 5]) { buffer in
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

    withBuffer(&array) { buffer in
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

