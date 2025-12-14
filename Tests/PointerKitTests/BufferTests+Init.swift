import Testing
@testable import PointerKit

extension BufferTests {
  @Test func initWithDifferentTypeBuffer() {
    let buffer1 = Buffer<Int64>(start: .init(0x1234), count: 5)
    let buffer2 = Buffer<UInt8>(buffer1)

    #expect(buffer2.start.address == 0x1234)
    #expect(buffer2.count == 8 * 5)
  }

  @Test func initWithSource() {
    let pointer = Pointer<Int64>(0x1234)
    let buffer = Buffer<UInt8>(source: pointer, sourceCount: 5)

    #expect(buffer.start.address == 0x1234)
    #expect(buffer.count == 8 * 5)
  }

  @Test func initWithDifferentTypeStartCount() {
    let buffer = Buffer<UInt8>(start: Pointer<Int64>(0x1234), count: 5)

    #expect(buffer.start.address == 0x1234)
    #expect(buffer.count == 5)
  }
}

