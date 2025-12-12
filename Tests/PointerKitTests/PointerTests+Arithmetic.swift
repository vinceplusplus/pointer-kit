import Testing
@testable import PointerKit

fileprivate struct Foo {
  var value1: Int64 = 0
  var value2: Int8 = 0
}

extension PointerTests {
  @Test func plus() {
    let value = Foo()
    let stride = MemoryLayout.stride(ofValue: value)

    withPointer(value) { pointer in
      #expect((pointer + 1).address - pointer.address == stride)
      #expect((pointer + 2).address - pointer.address == stride * 2)
    }
  }

  @Test func minus() {
    let value = Foo()
    let stride = MemoryLayout.stride(ofValue: value)

    withPointer(value) { pointer in
      #expect(pointer.address - (pointer - 1).address == stride)
      #expect(pointer.address - (pointer - 2).address == stride * 2)
    }
  }

  @Test func plusEqual() {
    let value = Foo()
    let stride = MemoryLayout.stride(ofValue: value)

    withPointer(value) { pointer1 in
      var pointer2 = pointer1

      #expect(pointer1.address == pointer2.address)

      pointer2 += 1
      #expect(pointer2.address - pointer1.address == stride)

      pointer2 += 2
      #expect(pointer2.address - pointer1.address == stride * 3)
    }
  }

  @Test func minusEqual() {
    let value = Foo()
    let stride = MemoryLayout.stride(ofValue: value)

    withPointer(value) { pointer1 in
      var pointer2 = pointer1

      #expect(pointer1.address == pointer2.address)

      pointer2 -= 1
      #expect(pointer1.address - pointer2.address == stride)

      pointer2 -= 2
      #expect(pointer1.address - pointer2.address == stride * 3)
    }
  }
}

extension PointerTests {
  @Test func minusPointer() {
    let value = Foo()

    withPointer(value) { pointer in
      #expect((pointer + 1) - pointer == 1)
      #expect(pointer + 2 - pointer == 2)
    }
  }
}

