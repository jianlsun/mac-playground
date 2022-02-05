//
//  ViewController.swift
//  EggTimer
//
//  Created by jianlsun on 2022/1/22.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var timeLeftField: NSTextField!
    
    @IBOutlet weak var eggImageView: NSImageView!
    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    @IBOutlet weak var resetButton: NSButton!
    
    var eggTimer = EggTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eggTimer.delegate = self
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func startButtonClicked(_ sender: Any) {
        if eggTimer.isPause {
            eggTimer.remuseTimer()
        } else {
            eggTimer.duration = 360
            eggTimer.startTimer()
        }
        configButtonsAndMenus()
    }
    
    @IBAction func stopButtonClicked(_ sender: Any) {
        eggTimer.stopTimer()
        configButtonsAndMenus()
    }
    
    @IBAction func resetButtonClicked(_ sender: Any) {
        eggTimer.resetTimer()
        updateDisplay(for: 360)
        configButtonsAndMenus()
    }
    
    // MARK: - IBActions menu
    
    @IBAction func startTimerMenuItemSelected(_ sender: Any) {
        startButtonClicked(sender)
    }
    
    @IBAction func stopTimerMenuItemSelected(_ sender: Any) {
        stopButtonClicked(sender)
    }
    
    @IBAction func resetTimerMenuItemSelected(_ sender: Any) {
        resetButtonClicked(sender)
    }
    
    // MARK: - Display
    func updateDisplay(for timeRemining: TimeInterval) {
        timeLeftField.stringValue = textToDisplay(for: timeRemining)
        eggImageView.image = imageToDisplay(for: timeRemining)
    }
    
    private func textToDisplay(for timeRemining: TimeInterval) -> String {
        if timeRemining == 0 {
            return "Done!"
        }
        
        let minuteRemining = floor(timeRemining / 60)
        let secondsRemining = timeRemining - 60 * minuteRemining
        let secondsDisplay = String(format:"%02d", Int(secondsRemining))
        return "\(Int(minuteRemining)) : \(secondsDisplay)"
    }
    
    private func imageToDisplay(for timeRemining: TimeInterval) -> NSImage? {
        let percentComplete = 100 - (timeRemining / 360 * 100)
        
        if eggTimer.isStop {
            let stopImageName = timeRemining == 0 ? "100" : "stopped"
            return NSImage(named: stopImageName)
        }
        
        let imageName: String
        switch percentComplete {
        case 0..<25: imageName = "0"
        case 25..<50: imageName = "25"
        case 50..<75: imageName = "50"
        case 75..<100: imageName = "75"
        default: imageName = "100"
        }
        
        return NSImage(named: imageName)
    }
    
    private func configButtonsAndMenus() {
        var enableStart: Bool
        var enableStop: Bool
        var enableReset: Bool
        
        if eggTimer.isStop {
            enableStart = true
            enableStop = false
            enableReset = false
        } else if eggTimer.isPause {
            enableStart = true
            enableStop = false
            enableReset = true
        } else {
            enableStart = false
            enableStop = true
            enableReset = false
        }
        
        startButton.isEnabled = enableStart
        stopButton.isEnabled = enableStop
        resetButton.isEnabled = enableReset
        
        if let appDelegate = NSApplication.shared.delegate as? AppDelegate {
            appDelegate.enableMenus(start: enableStart, stop: enableStop, reset: enableReset)
        }
    }
}

extension ViewController : EggTimerProtocol {
    func timeReminingOnTimer(_ timer: EggTimer, timeRemining: TimeInterval) {
        updateDisplay(for: timeRemining)
    }
    
    func timeHasFinished(_ timer: EggTimer) {
        updateDisplay(for: 0)
        configButtonsAndMenus()
    }
}

