import Foundation
import SharedKit

/// Privileged helper for reading file contents.
final class FinderService: NSObject, ServiceInterface, FinderInterface {

  /// XPC interface for collecting logs.
  static let interface: Protocol = FinderInterface.self

  /// Loads files from the given folder.
  func filesInFolder(_ path: String, reply: @escaping ([String], Error?) -> Void) {
    do {
      reply(try FileManager.default.contentsOfDirectory(atPath: path), nil)
    } catch {
      reply([], error)
    }
  }
}

// Accept XPC connections and return description
NSXPCListener.run(serviceInterfaceType: FinderService.self)
