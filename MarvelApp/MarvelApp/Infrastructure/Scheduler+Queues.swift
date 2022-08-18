//
//  Scheduler+Queues.swift
//  MarvelApp
//
//  Created by Pau Blanes on 18/8/22.
//

import Combine
import Dispatch

extension Scheduler where Self == DispatchQueue {
    static var main: Self { DispatchQueue.main }
    static var global: Self { DispatchQueue.global() }
}
