import Testing
@testable import PointerKit

extension BufferTests {
  @Test func zeros() {
    Buffer<Int64>.zeros(5) { buffer in
      #expect(buffer.count == 5)
      #expect(buffer[0] == 0)
      #expect(buffer[1] == 0)
      #expect(buffer[2] == 0)
      #expect(buffer[3] == 0)
      #expect(buffer[4] == 0)
    }
  }
}

