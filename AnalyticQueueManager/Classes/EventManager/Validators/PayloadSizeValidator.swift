//
//  PayloadSizeValidator.swift
//  AnalyticQueueManager
//
//  Created by B0223972 on 12/05/22.
//

import Foundation

struct PayloadSizeValidator: EventRequestValidator {
    
    let kbsIn1MB = 1024
    let sizeInKB: Int64
    
    var required: Bool = false
    
    init(sizeInKB: Int64) {
        self.sizeInKB = sizeInKB
    }
    
    func validate(events: [Event]) -> EventValidatorResponse {
        var totalEventData = Data()
        for (index, event) in events.enumerated() {
            if let eventData = try? JSONSerialization.data(withJSONObject: event.payload, options: []) {
                totalEventData.append(eventData)
                if Int64(totalEventData.count / kbsIn1MB) >= sizeInKB {
                    return index == 0 ? (true, index) : (true, index - 1)
                }
            }
        }
        return (false, nil)
    }
}
