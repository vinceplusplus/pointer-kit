import Testing
@testable import PointerKit

extension BufferTests {
  @Test func `nil`() {
    #expect(Buffer<Int>.nil.start.address == 0)
    #expect(Buffer<Int>.nil.count == 0)
  }
}

