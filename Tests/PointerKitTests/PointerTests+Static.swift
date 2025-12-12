import Testing
@testable import PointerKit

extension PointerTests {
  @Test func `nil`() {
    #expect(Pointer<Int>.nil.address == 0)
  }
}

