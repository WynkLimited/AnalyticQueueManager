//
//  PersistenceManager.swift
//  AnalyticQueueManager
//
//  Created by B0223972 on 05/05/22.
//

import Foundation

protocol QueueManagerPersistenceDelegate: AnyObject {
    func numberOfPendingEvents() -> Int
    func pendingEvents() -> [Event]
}

protocol PersistenceManagerDelegate {
    func eventDidPersistSuccessfully(event: [Event])
}

class PersistenceManager {
    
    typealias CompletionHandler = () -> Void
    
    func addEvent(event: Event,
                  success: @escaping CompletionHandler,
                  failure: @escaping CompletionHandler) {
        success()
    }
    
    func deleteEvent(event: [Event]) {
        
    }
}
