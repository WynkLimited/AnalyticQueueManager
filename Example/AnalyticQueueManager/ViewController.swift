//
//  ViewController.swift
//  AnalyticQueueManager
//
//  Created by nitinchadhawynk on 05/26/2022.
//  Copyright (c) 2022 nitinchadhawynk. All rights reserved.
//

import UIKit
import AnalyticQueueManager

class ViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let queueManager = EventQueueManager(maxEventLimit: 2, maxPayloadSize: 10, minRequestInterval: 2, delegate: self)
        
        queueManager.add(event: Event(payload: ["Hello": "avc"], priority: .normal))
        queueManager.add(event: Event(payload: ["World": "avc"], priority: .normal))
        queueManager.add(event: Event(payload: ["My": "avc"], priority: .normal))
        queueManager.add(event: Event(payload: ["Name": "avc"], priority: .normal))
    }
}

extension ViewController: EventQueueManagerRequestDelegate {
    func request(with events: [Event], success: @escaping () -> Void, failure: @escaping () -> Void) {
        print("ViewController request \(events)")
        success()
    }
}

class CustomValidator: EventRequestValidator {
 
    func validate(events: [Event]) -> EventValidatorResponse {
        return (isValid: true, requestCount: events.count)
    }
        
    var required: Bool = false
    
}


