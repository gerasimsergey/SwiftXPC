import Foundation

/// XPC interface for returning folder contents.
@objc protocol FinderInterface {

  /// Loads files from the given folder
  /// - Parameter path: Path in Finder.
  /// - Parameter reply: Callback with a list of files.
  func filesInFolder(_ path: String, reply: @escaping ([String], Error?) -> Void)
}
