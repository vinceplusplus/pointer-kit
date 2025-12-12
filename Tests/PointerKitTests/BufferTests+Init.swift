import Testing
@testable import PointerKit

extension BufferTests {
  @Test func initWithPointerCount() {
    let pointer = Pointer<Int>(0x1234)
    let buffer = Buffer<UInt8>(pointer, 5)

    #expect(buffer.start.address == 0x1234)
    #expect(buffer.count == 5)
  }

  @Test func initWithAnotherBuffer() {
    let buffer1 = Buffer<Int64>(Pointer<Int64>.init(0x1234), 5)
    let buffer2 = Buffer<UInt8>(buffer1)

    #expect(buffer2.start.address == 0x1234)
    #expect(buffer2.count == 8 * 5)
  }
}

