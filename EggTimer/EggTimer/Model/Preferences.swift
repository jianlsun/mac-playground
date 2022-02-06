//
//  Preferences.swift
//  EggTimer
//
//  Created by jianlsun on 2022/2/5.
//

import Foundation

struct Preferences {
    var selectedTime: TimeInterval {
        get {
            let savedTime = UserDefaults.standard.double(forKey: "selectedTime")
            return savedTime > 0 ? savedTime : 360
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "selectedTime")
        }
    }
}
