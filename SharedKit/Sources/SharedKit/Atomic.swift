import Foundation

/// Lightweight atomic accessor.
@propertyWrapper
public class Atomic<Value> {

  /// Underlying value.
  private var value: Value

  /// Lightweight lock.
  private var lock: os_unfair_lock_s = .init()

  /// Property wrapper requirement.
  public var wrappedValue: Value {
    get { access { $0 } }
    set { access { $0 = newValue } }
  }

  /// Creates a new accessor with the given initial value.
  /// - Parameter value: Initial value.
  public init(wrappedValue value: Value) {
    self.value = value
  }
}

// MARK: - Private API

private extension Atomic {

  /// Provides mutable access to the underlying value.
  func access<T>(_ accessor: (inout Value) -> T) -> T {
    os_unfair_lock_lock(&lock)
    defer { os_unfair_lock_unlock(&lock) }
    return accessor(&value)
  }
}
