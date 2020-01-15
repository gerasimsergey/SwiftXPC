import SwiftUI
import os
import SharedKit

/// Main content view.
struct MainView: View {

  /// Folder path.
  @State
  var folderPath: String = "/Applications"

  /// Folder contents.
  @State
  var folderContents: [String] = .init()

  /// Loading state.
  @State
  var isLoading: Bool = false

  /// Contents.
  var body: some View {
    VStack {
      HStack {
        TextField.init("Folder", text: $folderPath)
        Button("Load") {
          finderXPC.callProxy { proxy in
            proxy.filesInFolder(self.folderPath) { files, error in
              if let error = error {
                finderXPC.errorHandler(error)
              } else {
                DispatchQueue.main.async {
                  self.folderContents = files
                }
              }
            }
          }
        }
      }
      List {
        ForEach(self.folderContents, id: \.self) { name in
          Text(name)
        }
      }
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

// MARK: - Private API

/// Xcode canvas.
struct ContentViewCanvas: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}

/// Live XPC connection for collection logs.
private let finderXPC: SharedKit.XPC<FinderInterface> = .init(serviceName: "com.apple.feedback.SampleApp.SampleXPC") { error in
  DispatchQueue.main.async {
    if NSApp.presentError(error) { return }
    os_log(.error, log: events, "Cannot Present: %{public}s", String(describing: error))
  }
}

/// Local handle for logging events.
private let events: OSLog = .init(subsystem: "com.apple.feedback.SampleApp.Events", category: String(describing: MainView.self))
