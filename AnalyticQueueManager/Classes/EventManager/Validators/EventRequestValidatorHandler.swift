//
//  EventRequestValidator.swift
//  AnalyticQueueManager
//
//  Created by B0223972 on 12/05/22.
//

import Foundation

public protocol EventRequestValidator {
    
    func validate(events: [Event]) -> EventValidatorResponse
    
    var required: Bool { get }
}

public typealias EventValidatorResponse = (isValid: Bool, requestCount: Int?)

struct EventRequestValidatorHandler {
    
    var validators = [EventRequestValidator]()
    
    mutating func add(validator: EventRequestValidator) {
        self.validators.append(validator)
    }
    
    func validate(events: [Event]) -> EventValidatorResponse {
        var minimumCount = Int.max
        var isValid = false
        for validator in validators {
            let response = validator.validate(events: events)
            if !response.isValid, validator.required {
                return (false, minimumCount)
            } else if response.isValid == true, let requestCount = response.requestCount {
                if minimumCount > requestCount {
                    isValid = true
                    minimumCount = requestCount
                }
            }
        }
        return (isValid, minimumCount)
    }
}
