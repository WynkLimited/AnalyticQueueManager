//
//  AnalyticQueueManager.swift
//  AnalyticQueueManager
//
//  Created by B0223972 on 05/05/22.
//

import Foundation

public protocol EventQueueManagerRequestDelegate: AnyObject {
    func request(with events: [Event], success: @escaping () -> Void, failure: @escaping () -> Void)
}

public class EventQueueManager: ScheduledTimerValidatorDelegate {
    
    private var validatorHandler = EventRequestValidatorHandler()
    
    private var priorityQueue: PriorityQueue
    private var persistenceManager: PersistenceManager
    
    private weak var delegate: EventQueueManagerRequestDelegate?
    
    private init(delegate: EventQueueManagerRequestDelegate,
                 maxEventLimit: Int?,
                 maxPayloadSize:Int?,
                 minRequestInterval: TimeInterval?) {
        
        priorityQueue = PriorityQueue()
        persistenceManager = PersistenceManager()
        
        if let maxEventLimit = maxEventLimit {
            validatorHandler.add(validator: BatchSizeValidator(count: maxEventLimit))
        }
        
        if let maxPayloadSize = maxPayloadSize {
            validatorHandler.add(validator: PayloadSizeValidator(sizeInKB: Int64(maxPayloadSize)))
        }
        
        if let minRequestInterval = minRequestInterval {
            validatorHandler.add(validator: ScheduledTimerValidator(delegate: self, timeInterval: minRequestInterval))
        }
        
        self.delegate = delegate
    }
    
    convenience public init(maxEventLimit: Int,
                     minRequestInterval: TimeInterval?,
                     delegate: EventQueueManagerRequestDelegate
                    ) {
        self.init(delegate: delegate, maxEventLimit: maxEventLimit, maxPayloadSize: nil, minRequestInterval: minRequestInterval)
    }
    
    convenience public init(maxPayloadSize: Int,
                     minRequestInterval: TimeInterval?,
                     delegate: EventQueueManagerRequestDelegate) {
        self.init(delegate: delegate, maxEventLimit: nil, maxPayloadSize: maxPayloadSize, minRequestInterval: minRequestInterval)
    }
    
    convenience public init(maxEventLimit: Int,
                     maxPayloadSize: Int,
                     minRequestInterval: TimeInterval?,
                     delegate: EventQueueManagerRequestDelegate) {
        self.init(delegate: delegate, maxEventLimit: maxEventLimit, maxPayloadSize: maxPayloadSize, minRequestInterval: minRequestInterval)
    }
    
    public func add(event: Event) {
        persistenceManager.addEvent(event: event) {
            self.priorityQueue.enque(event: event)
            self.validateEvents()
        } failure: {
            
        }
    }
    
    private func validatePendingEvents(events: [Event]) {
        
        let response = validatorHandler.validate(events: events)
        if response.isValid, let dequeCount = response.requestCount, dequeCount > 0 {
            let events = priorityQueue.deque(count: dequeCount)
            delegate?.request(with: events, success: { [weak self] in
                self?.persistenceManager.deleteEvent(event: events)
            }, failure: {
                
            })
        }
    }
    
    func validateEvents() {
        validatePendingEvents(events: priorityQueue.events)
    }
}


