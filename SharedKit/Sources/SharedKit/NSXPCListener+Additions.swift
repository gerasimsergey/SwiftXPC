import Foundation

public extension NSXPCListener {

  /// Creates a XPC listener from the interface and runs it as a service.
  /// - Parameter serviceInterfaceType: Interface for a XPC service.
  class func run(serviceInterfaceType: ServiceInterface.Type) {
    let delegate = ServiceDelegate(serviceInterfaceType: serviceInterfaceType)
    let service = NSXPCListener.service()
    service.delegate = delegate
    service.resume()
  }
}
