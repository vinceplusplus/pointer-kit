public extension Pointer {
  func copy<V>(
    toValue value: inout V,
    as elementType: CopyElementType,
  ) {
    switch elementType {
    case .sourceElement:
      copy(toValue: &value, as: T.self)
    case .destinationElement:
      copy(toValue: &value, as: V.self)
    }
  }

  func copy<V, ElementType>(
    toValue value: inout V,
    as _: ElementType.Type,
  ) {
    copy(
      toValue: &value,
      byteCount: MemoryLayout<ElementType>.size,
    )
  }

  func copy<V>(
    toValue value: inout V,
    as elementType: CopySourceElementType,
    count: Int,
  ) {
    switch elementType {
    case .sourceElement:
      copy(toValue: &value, as: T.self, count: count)
    }
  }

  func copy<V, ElementType>(
    toValue value: inout V,
    as _: ElementType.Type,
    count: Int,
  ) {
    copy(
      toValue: &value,
      byteCount: MemoryLayout<ElementType>.stride * count,
    )
  }

  func copy<V>(
    toValue value: inout V,
    byteCount: Int,
  ) {
    withPointer(&value) { valuePointer in
      valuePointer.copy(
        fromPointer: self,
        byteCount: byteCount,
      )
    }
  }
}

