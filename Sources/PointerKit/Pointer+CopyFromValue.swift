public extension Pointer {
  func copy<S>(
    fromValue value: S,
    as elementType: CopyElementType,
  ) {
    switch elementType {
    case .sourceElement:
      copy(fromValue: value, as: S.self)
    case .destinationElement:
      copy(fromValue: value, as: T.self)
    }
  }

  func copy<S, ElementType>(
    fromValue value: S,
    as _: ElementType.Type,
  ) {
    copy(
      fromValue: value,
      byteCount: MemoryLayout<ElementType>.size,
    )
  }

  func copy<S>(
    fromValue value: S,
    as elementType: CopyDestinationElementType,
    count: Int,
  ) {
    switch elementType {
    case .destinationElement:
      copy(fromValue: value, as: T.self, count: count)
    }
  }

  func copy<S, ElementType>(
    fromValue value: S,
    as _: ElementType.Type,
    count: Int,
  ) {
    copy(
      fromValue: value,
      byteCount: MemoryLayout<ElementType>.stride * count,
    )
  }

  func copy<S>(
    fromValue value: S,
    byteCount: Int,
  ) {
    withPointer(value) { valuePointer in
      copy(
        fromPointer: valuePointer,
        byteCount: byteCount,
      )
    }
  }
}

