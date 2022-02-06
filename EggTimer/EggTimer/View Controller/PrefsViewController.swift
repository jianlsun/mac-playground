//
//  PrefsViewController.swift
//  EggTimer
//
//  Created by jianlsun on 2022/1/23.
//

import Cocoa

class PrefsViewController: NSViewController {

    @IBOutlet weak var presetPopup: NSPopUpButton!
    @IBOutlet weak var customSlider: NSSlider!
    @IBOutlet weak var customTextField: NSTextField!
    
    var prefs = Preferences()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showExistingPrefs()
    }
    
    @IBAction func popupValueChanged(_ sender: NSPopUpButton) {
        if sender.selectedItem?.title == "Custom" {
            customSlider.isEnabled = true
            return
        }
        
        let newDuration = sender.selectedTag()
        customSlider.integerValue = newDuration
        showSliderValueAsText()
        customSlider.isEnabled = false
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        showSliderValueAsText()
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        view.window?.close()
    }
    
    @IBAction func okButtonClicked(_ sender: Any) {
        saveNewPrefs()
        view.window?.close()
    }
    
    func showExistingPrefs() {
        guard !presetPopup.itemArray.isEmpty else { return }
        
        let selectedTimeMinutes = Int(prefs.selectedTime / 60)
        presetPopup.selectItem(at: presetPopup.itemArray.count  - 1)
        customSlider.isEnabled = true
        
        for item in presetPopup.itemArray {
            if item.tag == selectedTimeMinutes {
                presetPopup.select(item)
                customSlider.isEnabled = false
                break
            }
        }
        
        customSlider.integerValue = selectedTimeMinutes
        showSliderValueAsText()
    }
    
    func showSliderValueAsText() {
        let duration = customSlider.integerValue
        let description = duration == 1 ? "minute" : "minutes"
        customTextField.stringValue = "\(duration) \(description)"
    }
    
    func saveNewPrefs() {
        prefs.selectedTime = customSlider.doubleValue * 60
        NotificationCenter.default.post(name: Notification.Name(rawValue: "PrefsChanged"), object: nil)
        
    }
}
