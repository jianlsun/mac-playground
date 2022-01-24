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
    }
    
    @IBAction func stopButtonClicked(_ sender: Any) {
    }
    
    @IBAction func resetButtonClicked(_ sender: Any) {
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
        return ""
    }
    
    private func imageToDisplay(for timeRemining: TimeInterval) -> NSImage? {
        return nil
    }
}

extension ViewController : EggTimerProtocol {
    func timeReminingOnTimer(_ timer: EggTimer, timeRemining: TimeInterval) {
        updateDisplay(for: timeRemining)
    }
    
    func timeHasFinished(_ timer: EggTimer) {
        updateDisplay(for: 0)
    }
}

