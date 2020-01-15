import Foundation

/// Standard delegate for a XPC service.
final class ServiceDelegate: NSObject {

  /// Type of an interface for a XPC service.
  private let serviceInterfaceType: ServiceInterface.Type

  /// Creates a new delegate for a XPC listener.
  /// - Parameter serviceInterfaceType: Type of an interface for a XPC service.
  init(serviceInterfaceType: ServiceInterface.Type) {
    self.serviceInterfaceType = serviceInterfaceType
  }
}

// MARK: - NSXPCListenerDelegate

extension ServiceDelegate: NSXPCListenerDelegate {

  /// Accepts a new connection.
  /// - Parameter listener: XPC listener which owns this delegate.
  /// - Parameter newConnection: XPC connection in a pending state.
  func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
    let exportedObject = serviceInterfaceType.init()
    newConnection.exportedInterface = NSXPCInterface(with: serviceInterfaceType.interface)
    newConnection.exportedObject = exportedObject
    newConnection.resume()
    return true
  }
}
