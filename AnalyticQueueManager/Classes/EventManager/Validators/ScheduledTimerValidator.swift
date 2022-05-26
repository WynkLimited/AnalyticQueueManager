//
//  ScheduledTimerValidator.swift
//  AnalyticQueueManager
//
//  Created by B0223972 on 12/05/22.
//

import Foundation

protocol ScheduledTimerValidatorDelegate {
    func validateEvents()
}

class ScheduledTimerValidator: EventRequestValidator {
    
    private var delegate: ScheduledTimerValidatorDelegate
    
    private var timer: Timer?
    
    private var isValid: Bool = false
    
    var required: Bool = true
    
    init(delegate: ScheduledTimerValidatorDelegate,
         timeInterval: TimeInterval) {
        self.delegate = delegate
        self.timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(fireValidateEventsNotification), userInfo: nil, repeats: true)
    }
    
    @objc func fireValidateEventsNotification() {
        isValid = true
        delegate.validateEvents()
        isValid = false
    }
    
    func validate(events: [Event]) -> EventValidatorResponse {
        return isValid ? (true, events.count) : (false, nil)
    }
}
