import Testing
@testable import PointerKit

extension PointerTests {
  @Test func loadElement() {
    let value = 42

    withPointer(value) { pointer1 in
      let pointer2 = Pointer<Float>(pointer1)

      #expect(pointer2.loadElement(Int.self) == 42)
    }
  }

  @Test func loadArray() {
    let array = [42, 23]

    withBuffer(array: array) { buffer in
      let pointer2 = Pointer<Float>(buffer.start)

      #expect(Array(pointer2.loadArray(Int.self, 2)) == array)
    }
  }
}

