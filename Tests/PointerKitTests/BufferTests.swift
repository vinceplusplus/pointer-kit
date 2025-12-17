import Testing
@testable import PointerKit

@Suite
struct BufferTests {
  @Test func isNil() {
    #expect(Buffer<UInt8>(start: Pointer<UInt8>(0), count: 0).isNil == true)
    #expect(Buffer<UInt8>(start: Pointer<UInt8>(0x1234), count: 0).isNil == false)
  }
}

