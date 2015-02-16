//
//  AppDelegate.swift
//  Example
//
//  Created by Wittawas Nakkasem on 2/14/2558 BE.
//  Copyright (c) 2558 vittee. All rights reserved.
//

import Cocoa
import ThaiNum

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSTextDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var labelText: NSTextField!
    @IBOutlet weak var textFieldText: NSTextField!

    @IBOutlet weak var labelBaht: NSTextField!
    @IBOutlet weak var textFieldBaht: NSTextField!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    override func controlTextDidChange(notification: NSNotification) {
        if let source = notification.object as? NSTextField {
            if source == textFieldText {
                labelText.stringValue = ThaiNum.text(source.doubleValue)
                return
            }
            
            if source == textFieldBaht {
                labelBaht.stringValue = ThaiNum.bahtText(source.doubleValue)
                return
            }
        }
    }
}

