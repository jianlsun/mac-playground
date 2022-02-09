//
//  WindowController.swift
//  BabyScript
//
//  Created by jianlsun on 2022/2/9.
//

import Cocoa

class WindowController: NSWindowController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        shouldCascadeWindows = true
    }

    override func windowDidLoad() {
        super.windowDidLoad()
    
        if let window = window, let screen = window.screen {
            let offsetFromLeftOfScreen : CGFloat = 300
            let offsetFromTopOfScreen: CGFloat = 300
            let screenRect = screen.visibleFrame
            let newOrignY = screenRect.maxY - window.frame.height - offsetFromTopOfScreen
            window.setFrameOrigin(NSPoint(x: offsetFromLeftOfScreen, y: newOrignY))
        }
    }

}
