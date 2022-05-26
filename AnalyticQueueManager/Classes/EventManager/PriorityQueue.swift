//
//  PriorityQueue.swift
//  AnalyticQueueManager
//
//  Created by B0223972 on 05/05/22.
//

import Foundation

class PriorityQueue {
    
    var events = [Event]()
    
    func enque(event: Event) {
        if event.priority == .high {
            events = [event] + events
        } else {
            events.append(event)
        }
    }
    
    func deque(count: Int) -> [Event] {
        let prefixArray = events.prefix(count)
        events.removeFirst(count)
        return Array(prefixArray)
    }
}
