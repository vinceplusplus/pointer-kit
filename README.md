<p>
  <a href="https://github.com/vinceplusplus/pointer-kit/actions?query=workflow%3Atest-macos+event%3Apush">
    <img src="https://github.com/vinceplusplus/pointer-kit/workflows/test-macos/badge.svg">
  </a>
  <a href="https://github.com/vinceplusplus/pointer-kit/actions?query=workflow%3Atest-ios+event%3Apush">
    <img src="https://github.com/vinceplusplus/pointer-kit/workflows/test-ios/badge.svg">
  </a>
  <a href="https://codecov.io/gh/vinceplusplus/pointer-kit">
    <img src="https://codecov.io/gh/vinceplusplus/pointer-kit/branch/main/graph/badge.svg" />
  </a>
</p>

# pointer-kit

A lightweight, type-safe Swift wrapper around unsafe pointers. `pointer-kit` reduces the mental overhead of Swift's native pointer API by providing simple `Pointer<T>` and `Buffer<T>` types with an ergonomic copy interface.

## Why?

Swift's unsafe pointer APIs are powerful but carry a steep learning curve. There are **four** distinct pointer types (`UnsafePointer`, `UnsafeMutablePointer`, `UnsafeRawPointer`, `UnsafeMutableRawPointer`), each with different methods for reading, writing, and copying memory. Converting between them requires explicit casts, and byte-level operations quickly become verbose.

`pointer-kit` collapses this complexity into two types:

- [`Pointer<T>`](Sources/PointerKit/Pointer.swift) — A plain address wrapper. Hashable, Sendable, and layout-compatible with `UnsafePointer<T>`.
- [`Buffer<T>`](Sources/PointerKit/Buffer.swift) — A `Pointer<T>` paired with a count. Conforms to `Collection` and `MutableCollection`.

Both bridge to the native Swift pointer types via `unsafeBitCast` when you need full control, but for everyday use you rarely need to leave the `pointer-kit` world.

## Usage

### Pointer basics

```swift
import PointerKit

var value = 42

withPointer(&value) { pointer in
  // Read/write via pointee
  print(pointer.pointee) // 42
  pointer.pointee += 10
}

print(value) // 52
```

### Subscript access

```swift
var value = 0x1234

withPointer(&value, UInt8.self) { pointer in
  print(pointer[0]) // 0x34  (little-endian first byte)
  print(pointer[1]) // 0x12

  pointer[0] = 0xFF
}

print(value) // 0x12FF
```

### Arithmetic

```swift
var array: [UInt8] = [0xAA, 0xBB, 0xCC, 0xDD]

withBuffer(array: &array) { buffer in
  let secondElement = buffer.start + 1
  print(secondElement.pointee) // 0xBB

  let offset = secondElement - buffer.start
  print(offset) // 1
}
```

### Buffer as Collection

```swift
let array: [UInt8] = [0x01, 0x02, 0x03]

withBuffer(array: array) { buffer in
  for byte in buffer {
    print(byte)
  }

  let sliced = buffer[buffer.startIndex ..< buffer.startIndex + 2]
  print(Array(sliced)) // [0x01, 0x02]
}
```

### Copy between pointers

```swift
var source: UInt8 = 0x12
var destination: Int64 = 0x12345678

withPointer(&destination) { destinationPointer in
  withPointer(&source) { sourcePointer in
    // Copy 1 byte using the source element stride (UInt8 = 1 byte)
    destinationPointer.copy(fromPointer: sourcePointer, as: .sourceElement)
  }
}

print(destination) // 0x12345612
```

The [`CopyElementType`](Sources/PointerKit/Types.swift) enum lets you choose which type's stride to use:

```swift
destinationPointer.copy(fromPointer: sourcePointer, as: .sourceElement)       // uses MemoryLayout<S>.size
destinationPointer.copy(fromPointer: sourcePointer, as: .destinationElement)  // uses MemoryLayout<T>.size
destinationPointer.copy(fromPointer: sourcePointer, as: UInt16.self)          // explicit type
```

### Copy with element count

```swift
var source: UInt32 = 0x12345678
var destination: UInt32 = 0

withPointer(&source, UInt8.self) { sourcePointer in
  withPointer(&destination) { destinationPointer in
    // Copy 3 UInt8 elements (3 bytes) from source to destination
    destinationPointer.copy(fromPointer: sourcePointer, as: .sourceElement, count: 3)
  }
}

print(destination) // 0x345678
```

### Copy from value to pointer

```swift
var destination: Int64 = 0x12345678

withPointer(&destination) { destinationPointer in
  destinationPointer.copy(fromValue: 0x12 as UInt8, as: .sourceElement)
}

print(destination) // 0x12345612
```

### Copy from pointer to value

```swift
var value: UInt8 = 0

withPointer(0x12345678 as Int64) { sourcePointer in
  sourcePointer.copy(toValue: &value, as: .destinationElement)
}

print(value) // 0x78
```

### Free function copy (no withPointer needed)

```swift
var destination: Int64 = 0x12345678
let source: UInt8 = 0x12

copy(fromValue: source, toValue: &destination, as: .sourceElement)

print(destination) // 0x12345612
```

### Buffer.zeros

```swift
Buffer<Int64>.zeros(4) { buffer in
  for i in 0 ..< buffer.count {
    print(buffer[i]) // 0, 0, 0, 0
  }
}
```

### Type reinterpretation

```swift
// Reinterpret an Int64 as 8 UInt8 bytes
var value: Int64 = 0x12345678

withPointer(&value, UInt8.self) { pointer in
  print(pointer[0]) // 0x78
  print(pointer[3]) // 0x12
}

// Reinterpret an array of one type as another
var source: Int64 = 0x12345678
var destination: Int32 = 0

withPointer(&source, UInt8.self) { sourcePointer in
  withPointer(&destination) { destinationPointer in
    destinationPointer.copy(fromPointer: sourcePointer, as: .sourceElement, count: 3)
  }
}

print(destination) // 0x345678
```

## Installation

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
  .package(url: "https://github.com/vinceplusplus/pointer-kit", from: "1.0.0"),
]
```

## API Overview

### Types

| Type                                                           | Description                                                                            |
| -------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| [`Pointer<T>`](Sources/PointerKit/Pointer.swift)               | Typed address wrapper. Hashable, Sendable.                                             |
| [`Buffer<T>`](Sources/PointerKit/Buffer.swift)                 | Pointer + count. Collection & MutableCollection.                                       |
| [`CopyElementType`](Sources/PointerKit/Types.swift)            | `.sourceElement` / `.destinationElement` — selects which type's stride governs a copy. |
| [`CopySourceElementType`](Sources/PointerKit/Types.swift)      | `.sourceElement` — narrows the choice for count-based copy-to-value.                   |
| [`CopyDestinationElementType`](Sources/PointerKit/Types.swift) | `.destinationElement` — narrows the choice for count-based copy-from-value.            |

### Pointer extensions

| File                                                                          | Methods                                                                                |
| ----------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| [`Pointer+Init`](Sources/PointerKit/Pointer+Init.swift)                       | `init(_: Int)`, `init(_: Pointer<S>)`                                                  |
| [`Pointer+Static`](Sources/PointerKit/Pointer+Static.swift)                   | `.nil`                                                                                 |
| [`Pointer+Subscripting`](Sources/PointerKit/Pointer+Subscripting.swift)       | `subscript(position:)`                                                                 |
| [`Pointer+Arithmetic`](Sources/PointerKit/Pointer+Arithmetic.swift)           | `+`, `-`, `+=`, `-=` (element-stride arithmetic)                                       |
| [`Pointer+Load`](Sources/PointerKit/Pointer+Load.swift)                       | `loadElement(_:)`, `loadArray(_:_:)`                                                   |
| [`Pointer+Native`](Sources/PointerKit/Pointer+Native.swift)                   | `native()`, `nativeMutable()`, `nativeRaw()`, `nativeMutableRaw()`                     |
| [`Pointer+NativeInit`](Sources/PointerKit/Pointer+NativeInit.swift)           | `init(_: UnsafeRawPointer)`                                                            |
| [`Pointer+CopyFromPointer`](Sources/PointerKit/Pointer+CopyFromPointer.swift) | `copy(fromPointer:as:)`, `copy(fromPointer:as:count:)`, `copy(fromPointer:byteCount:)` |
| [`Pointer+CopyFromValue`](Sources/PointerKit/Pointer+CopyFromValue.swift)     | `copy(fromValue:as:)`, `copy(fromValue:as:count:)`, `copy(fromValue:byteCount:)`       |
| [`Pointer+CopyToValue`](Sources/PointerKit/Pointer+CopyToValue.swift)         | `copy(toValue:as:)`, `copy(toValue:as:count:)`, `copy(toValue:byteCount:)`             |

### Buffer extensions

| File                                                              | Methods                                                                                                                                        |
| ----------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| [`Buffer+Init`](Sources/PointerKit/Buffer+Init.swift)             | `init(_: Buffer<S>)`, `init(source:sourceCount:)`, `init(start:count:)`                                                                        |
| [`Buffer+Static`](Sources/PointerKit/Buffer+Static.swift)         | `.nil`                                                                                                                                         |
| [`Buffer+Collection`](Sources/PointerKit/Buffer+Collection.swift) | Conforms to `Collection` and `MutableCollection`                                                                                               |
| [`Buffer+Misc`](Sources/PointerKit/Buffer+Misc.swift)             | `zeros(_:_:)`                                                                                                                                  |
| [`Buffer+Native`](Sources/PointerKit/Buffer+Native.swift)         | `native()`, `nativeMutable()`, `nativeRaw()`, `nativeMutableRaw()`                                                                             |
| [`Buffer+NativeInit`](Sources/PointerKit/Buffer+NativeInit.swift) | Inits from `UnsafeBufferPointer`, `UnsafeMutableBufferPointer`, `UnsafeRawBufferPointer`, `UnsafeMutableRawBufferPointer`, raw pointer + count |

### Free functions

| File                                                              | Functions                                                                                                |
| ----------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| [`Pointer+Utilities`](Sources/PointerKit/Pointer+Utilities.swift) | `withPointer(_:body:)`, `withPointer(_:_:body:)` (4 overloads)                                           |
| [`Buffer+Utilities`](Sources/PointerKit/Buffer+Utilities.swift)   | `withBuffer(element:body:)`, `withBuffer(array:body:)` (4 overloads)                                     |
| [`Utilities+Copy`](Sources/PointerKit/Utilities+Copy.swift)       | `copy(fromValue:toValue:as:)`, `copy(fromValue:toValue:as:count:)`, `copy(fromValue:toValue:byteCount:)` |

## Layout Compatibility

`Pointer<T>` is layout-compatible with `UnsafePointer<T>` — both are a single `Int` representing an address. This allows `unsafeBitCast` between them. `Buffer<T>` is layout-compatible with `UnsafeBufferPointer<T>` — both are an `(Int, Int)` tuple of `(address, count)`. These assumptions hold on all current Apple platforms and architectures.

## License

`pointer-kit` is available under the MIT license. See the [LICENSE](LICENSE) file for details.
