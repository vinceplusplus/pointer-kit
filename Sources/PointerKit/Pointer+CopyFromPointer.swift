public extension Pointer {
  func copy<S>(
    fromPointer pointer: Pointer<S>,
    as elementType: CopyElementType,
  ) {
    switch elementType {
    case .sourceElement:
      copy(fromPointer: pointer, as: S.self)
    case .destinationElement:
      copy(fromPointer: pointer, as: T.self)
    }
  }

  func copy<S, ElementType>(
    fromPointer pointer: Pointer<S>,
    as _: ElementType.Type,
  ) {
    copy(
      fromPointer: pointer,
      byteCount: MemoryLayout<ElementType>.size,
    )
  }

  func copy<S>(fromPointer pointer: Pointer<S>, as elementType: CopyElementType, count: Int) {
    switch elementType {
    case .sourceElement:
      copy(fromPointer: pointer, as: S.self, count: count)
    case .destinationElement:
      copy(fromPointer: pointer, as: T.self, count: count)
    }
  }

  func copy<S, ElementType>(fromPointer pointer: Pointer<S>, as _: ElementType.Type, count: Int) {
    copy(
      fromPointer: pointer,
      byteCount: MemoryLayout<ElementType>.stride * count,
    )
  }

  func copy<S>(
    fromPointer pointer: Pointer<S>,
    byteCount: Int,
  ) {
    nativeMutableRaw().copyMemory(
      from: pointer.nativeRaw(),
      byteCount: byteCount,
    )
  }
}

