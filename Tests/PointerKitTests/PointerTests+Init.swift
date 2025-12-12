import Testing
@testable import PointerKit

extension PointerTests {
  @Test func initWithInt() {
    let pointer = Pointer<Int>(0x1000)

    #expect(pointer.address == 0x1000)
  }

  @Test func initWithAnotherPointer() {
    let pointer1 = Pointer<Int>(0x1000)
    let pointer2 = Pointer<Int8>(pointer1)

    #expect(pointer1.address == pointer2.address)
  }
}

