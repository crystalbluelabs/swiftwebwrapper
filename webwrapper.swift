#!/usr/bin/env xcrun swift -i 

import WebKit

// Setup Application 
let application = NSApplication.sharedApplication()
application.setActivationPolicy(NSApplicationActivationPolicy.Regular)

// Create Display Window
let window = NSWindow(contentRect: NSMakeRect(0, 0, 800, 600), styleMask: NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask, backing: .Buffered, defer: false)
window.center()
window.title = "Swift Wrapper : " + Process.arguments[0]
window.makeKeyAndOrderFront(window)


// Handle window close event with click of red dot
class WindowDelegate: NSObject, NSWindowDelegate {
	func windowWillClose(notification: NSNotification?) {
		NSApplication.sharedApplication().terminate(0)
	}
}

let windowDelegate = WindowDelegate()
window.delegate = windowDelegate


// Application Delegate 
class ApplicationDelegate: NSObject, NSApplicationDelegate {
	var _window : NSWindow

	init(window: NSWindow) {
		self._window = window
	}

	func applicationDidFinishLaunching(notification: NSNotification?) {

		var url : NSURL
		let webView = WebView(frame: self._window.contentView.frame)
		self._window.contentView.addSubview(webView)

		if Process.arguments[0].isEmpty {
			url = NSURL(string: "http://www.mutualmobile.com")
		} else {
			url = NSURL(string: Process.arguments[0])
		}
		window.title = "Swift Wrapper : " + url.absoluteString
		webView.mainFrame.loadRequest(NSURLRequest(URL: url))
	}
}

let applicationDelegate = ApplicationDelegate(window: window)
application.delegate = applicationDelegate
application.activateIgnoringOtherApps(true)
application.run()