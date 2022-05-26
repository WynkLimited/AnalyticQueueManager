//
//  BatchSizeValidator.swift
//  AnalyticQueueManager
//
//  Created by B0223972 on 12/05/22.
//

import Foundation

struct BatchSizeValidator: EventRequestValidator {
    
    let count: Int
    
    var required: Bool = false
    
    init(count: Int) {
        self.count = count
    }
    
    func validate(events: [Event]) -> EventValidatorResponse {
        return events.count >= count ? (true, count) : (false, nil)
    }
}
