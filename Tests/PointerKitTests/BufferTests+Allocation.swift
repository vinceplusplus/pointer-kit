import Testing
@testable import PointerKit

extension BufferTests {
  @Test func allocate() {
    let buffer = Buffer<Int32>.allocate(count: 5)

    #expect(buffer.count == 5)
    #expect(buffer.isNil == false)

    buffer[0] = 10
    buffer[1] = 20
    buffer[2] = 30
    buffer[3] = 40
    buffer[4] = 50

    #expect(buffer[0] == 10)
    #expect(buffer[1] == 20)
    #expect(buffer[2] == 30)
    #expect(buffer[3] == 40)
    #expect(buffer[4] == 50)

    buffer.deallocate()
  }

  @Test func allocateZeroCount() {
    let buffer = Buffer<Int32>.allocate(count: 0)

    #expect(buffer.count == 0)

    buffer.deallocate()
  }

  @Test func allocateAlignment() {
    let buffer = Buffer<Int32>.allocate(count: 3, alignment: 64)

    #expect(buffer.count == 3)
    #expect(buffer.start.address % 64 == 0)

    buffer.deallocate()
  }
}
