import SwiftUI
import WebKit

@main
struct WebShellApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .ignoresSafeArea(.all)
                .statusBarHidden(false)
                .preferredColorScheme(.dark)
        }
    }
}

struct ContentView: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.defaultWebpagePreferences.allowsContentJavaScript = true
        config.preferences.javaScriptCanOpenWindowsAutomatically = false

        let web = WKWebView(frame: .zero, configuration: config)
        web.isOpaque = false
        web.backgroundColor = UIColor(red: 0.043, green: 0.059, blue: 0.102, alpha: 1)
        web.scrollView.contentInsetAdjustmentBehavior = .never
        web.allowsBackForwardNavigationGestures = true

        guard let base = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "www") else {
            return web
        }
        let root = base.deletingLastPathComponent()
        web.loadFileURL(base, allowingReadAccessTo: root)
        return web
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
