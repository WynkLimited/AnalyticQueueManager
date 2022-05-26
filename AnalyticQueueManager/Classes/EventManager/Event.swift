//
//  Event.swift
//  AnalyticQueueManager
//
//  Created by B0223972 on 05/05/22.
//

import Foundation

public struct Event: Identifiable {
    public var id: String
    public var payload: Any
    public var priority: Priority
    
    public init(id: String = UUID().uuidString, payload: Any, priority: Priority = .normal) {
        self.id = id
        self.payload = payload
        self.priority = priority
    }
}
