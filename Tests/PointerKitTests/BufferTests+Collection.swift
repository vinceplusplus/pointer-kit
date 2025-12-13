import Testing
@testable import PointerKit

extension BufferTests {
  @Test func collection() {
    withBuffer(array: [1, 2, 3]) { buffer in
      #expect(buffer[0] == 1)
      #expect(buffer[1] == 2)
      #expect(buffer[2] == 3)
    }
  }

  @Test func mutableCollection() {
    var array = [1, 2, 3]

    withBuffer(array: &array) { buffer in
      #expect(buffer[0] == 1)
      #expect(buffer[1] == 2)
      #expect(buffer[2] == 3)

      buffer[0] += 1
      buffer[1] += 2
      buffer[2] += 3

      #expect(buffer[0] == 2)
      #expect(buffer[1] == 4)
      #expect(buffer[2] == 6)
    }

    #expect(array == [2, 4, 6])
  }
}

