import Foundation

/// Interface for a XPC service.
public protocol ServiceInterface: NSObjectProtocol {

  /// Exported interface for a XPC service.
  static var interface: Protocol { get }

  /// Creates a remote object.
  init()
}
