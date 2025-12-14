import Testing
@testable import PointerKit

extension BufferTests {
  @Test func unsafeBufferPointer() {
    [1, 2, 3, 4, 5].withUnsafeBufferPointer { unsafeBufferPointer in
      let buffer = Buffer<Int>(unsafeBufferPointer)

      #expect(buffer.count == 5)
      #expect(buffer[0] == 1)
      #expect(buffer[1] == 2)
      #expect(buffer[2] == 3)
      #expect(buffer[3] == 4)
      #expect(buffer[4] == 5)
    }
  }

  @Test func unsafeMutableBufferPointer() {
    var array = [1, 2, 3, 4, 5]

    array.withUnsafeMutableBufferPointer { unsafeMutableBufferPointer in
      let buffer = Buffer<Int>(unsafeMutableBufferPointer)

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

  @Test func unsafeRawBufferPointer() {
    withUnsafeBytes(of: 0x1234567813572468 as Int64) { unsafeRawBufferPointer in
      let buffer = Buffer<UInt8>(unsafeRawBufferPointer)

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

  @Test func unsafeMutableRawBufferPointer() {
    var value = 0x1234567813572468 as Int64

    withUnsafeMutableBytes(of: &value) { unsafeMutableRawBufferPointer in
      let buffer = Buffer<UInt8>(unsafeMutableRawBufferPointer)

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
}

extension BufferTests {
  @Test func differentTypeUnsafeBufferPointer() {
    ([1, 2, 3, 4, 5] as [Int64]).withUnsafeBufferPointer { unsafeBufferPointer in
      let buffer = Buffer<UInt8>(unsafeBufferPointer)

      #expect(buffer.count == 40)
      #expect(buffer[0] == 1)
      #expect(buffer[8] == 2)
      #expect(buffer[16] == 3)
      #expect(buffer[24] == 4)
      #expect(buffer[32] == 5)
    }
  }

  @Test func differentTypeUnsafeMutableBufferPointer() {
    var array = [1, 2, 3, 4, 5] as [Int64]

    array.withUnsafeMutableBufferPointer { unsafeMutableBufferPointer in
      let buffer = Buffer<UInt8>(unsafeMutableBufferPointer)

      #expect(buffer.count == 40)
      #expect(buffer[0] == 1)
      #expect(buffer[8] == 2)
      #expect(buffer[16] == 3)
      #expect(buffer[24] == 4)
      #expect(buffer[32] == 5)

      buffer[0] += 1
      buffer[8] += 2
      buffer[16] += 3
      buffer[24] += 4
      buffer[32] += 5

      #expect(buffer[0] == 2)
      #expect(buffer[8] == 4)
      #expect(buffer[16] == 6)
      #expect(buffer[24] == 8)
      #expect(buffer[32] == 10)
    }

    #expect(array == [2, 4, 6, 8, 10])
  }
}

extension BufferTests {
  @Test func unsafeRawPointerCount() {
    let buffer = Buffer<Int64>(
      bytes: UnsafeRawPointer(bitPattern: 0x1234)!,
      byteCount: 40,
    )

    #expect(buffer.start.address == 0x1234)
    #expect(buffer.count == 5)
  }

  @Test func unsafeMutableRawPointerCount() {
    let buffer = Buffer<Int64>(
      bytes: UnsafeMutableRawPointer(bitPattern: 0x1234)!,
      byteCount: 40,
    )

    #expect(buffer.start.address == 0x1234)
    #expect(buffer.count == 5)
  }

  @Test func differentTypeUnsafeSource() {
    let buffer = Buffer<UInt8>(
      source: UnsafePointer<Int64>(bitPattern: 0x1234)!,
      sourceCount: 5,
    )

    #expect(buffer.start.address == 0x1234)
    #expect(buffer.count == 40)
  }

  @Test func differentTypeUnsafeMutableSource() {
    let buffer = Buffer<UInt8>(
      source: UnsafeMutablePointer<Int64>(bitPattern: 0x1234)!,
      sourceCount: 5,
    )

    #expect(buffer.start.address == 0x1234)
    #expect(buffer.count == 40)
  }

  @Test func differentTypeUnsafeStartCount() {
    let buffer = Buffer<UInt8>(
      start: UnsafePointer<Int64>(bitPattern: 0x1234)!,
      count: 5,
    )

    #expect(buffer.start.address == 0x1234)
    #expect(buffer.count == 5)
  }

  @Test func differentTypeUnsafeMutableStartCount() {
    let buffer = Buffer<UInt8>(
      start: UnsafeMutablePointer<Int64>(bitPattern: 0x1234)!,
      count: 5,
    )

    #expect(buffer.start.address == 0x1234)
    #expect(buffer.count == 5)
  }
}

