public func copy<S, T>(
  fromValue sourceValue: S,
  toValue destinationValue: inout T,
  as elementType: CopyElementType,
) {
  switch elementType {
  case .sourceElement:
    copy(
      fromValue: sourceValue,
      toValue: &destinationValue,
      as: S.self,
    )
  case .destinationElement:
    copy(
      fromValue: sourceValue,
      toValue: &destinationValue,
      as: T.self,
    )
  }
}

public func copy<S, T, ElementType>(
  fromValue sourceValue: S,
  toValue destinationValue: inout T,
  as _: ElementType.Type,
) {
  copy(
    fromValue: sourceValue,
    toValue: &destinationValue,
    byteCount: MemoryLayout<ElementType>.size,
  )
}

public func copy<S, T, ElementType>(
  fromValue sourceValue: S,
  toValue destinationValue: inout T,
  as _: ElementType.Type,
  count: Int,
) {
  copy(
    fromValue: sourceValue,
    toValue: &destinationValue,
    byteCount: MemoryLayout<ElementType>.stride * count,
  )
}

public func copy<S, T>(
  fromValue sourceValue: S,
  toValue destinationValue: inout T,
  byteCount: Int,
) {
  withPointer(&destinationValue) { destinationPointer in
    destinationPointer.copy(
      fromValue: sourceValue,
      byteCount: byteCount,
    )
  }
}
