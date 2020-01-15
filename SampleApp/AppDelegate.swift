import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  /// Main window.
  var window: NSWindow?

  /// Creates and shows the main window.
  func applicationDidFinishLaunching(_ aNotification: Notification) {
    let mask: NSWindow.StyleMask = [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView]
    window = NSWindow(contentRect: .init(x: 0, y: 0, width: 480, height: 300), styleMask: mask, backing: .buffered, defer: false)
    window?.center()
    window?.contentView = NSHostingView(rootView: MainView())
    window?.makeKeyAndOrderFront(nil)
  }

  /// Quit the app when you close the window.
  func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    true
  }
}
