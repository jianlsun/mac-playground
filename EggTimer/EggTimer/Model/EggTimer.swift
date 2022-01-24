//
//  EggTimer.swift
//  EggTimer
//
//  Created by jianlsun on 2022/1/24.
//

import Foundation

protocol EggTimerProtocol {
    func timeReminingOnTimer(_ timer: EggTimer, timeRemining: TimeInterval)
    func timeHasFinished(_ timer: EggTimer)
}

class EggTimer {
    var timer: Timer? = nil
    var duration: TimeInterval = 360
    var startTime: Date?
    var elapsedTime: TimeInterval = 0
    
    var isStop : Bool {
        return timer == nil && elapsedTime == 0
    }
    
    var isPause : Bool {
        return timer == nil && elapsedTime > 0
    }
    
    var delegate : EggTimerProtocol?
    
    func timeAction() {
        guard let startTime = startTime else {
            return
        }

        elapsedTime = -startTime.timeIntervalSinceNow
        let secondsRemining = (duration - elapsedTime).rounded()
        if secondsRemining <= 0 {
            delegate?.timeHasFinished(self)
        } else {
            delegate?.timeReminingOnTimer(self, timeRemining: secondsRemining)
        }
    }
    
    func startTimer() {
        startTime = Date()
        elapsedTime = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.timeAction()
        }
        timeAction()
    }
    
    func remuseTimer() {
        startTime = Date(timeIntervalSinceNow: -elapsedTime)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.timeAction()
        }
        timeAction()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        timeAction()
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        startTime = nil
        elapsedTime = 0
        duration = 360
        timeAction()
    }
}
