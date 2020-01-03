//
//  AppDelegate.swift
//  spot-check
//
//  Created by Jacob Casper on 1/2/20.
//  Copyright © 2020 ghostware. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        let menu = NSMenu.init()
        menu.addItem(withTitle: "Quit", action: #selector(quit), keyEquivalent: "q")
        self.statusItem.menu = menu


        if let button = self.statusItem.button {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
                button.title = self.getTrackTitle()
            }
        }

    }

    func getTrackTitle() -> String {
        let script = (NSAppleScript.init(source: "tell application \"Spotify\" to (get name of current track) & \" - \" & (get artist of current track)"))!
        var error = NSDictionary?(nil)
        let info = script.executeAndReturnError(&error).stringValue
        return info ?? "nil"
    }


    // MARK: - Exit

    @objc func quit() {
        NSApplication.shared.terminate(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}
