import Testing
@testable import PointerKit

extension PointerTests {
  @Test func subscripting() {
    var array = [1, 2, 3]

    withBuffer(array: &array) { buffer in
      let start = buffer.start

      #expect(start[0] == 1)
      #expect(start[1] == 2)
      #expect(start[2] == 3)

      start[0] += 3
      start[1] += 4
      start[2] += 5

      #expect(start[0] == 4)
      #expect(start[1] == 6)
      #expect(start[2] == 8)
    }

    #expect(array[0] == 4)
    #expect(array[1] == 6)
    #expect(array[2] == 8)
  }
}

