//
//  GGNObservable.swift
//  Pods
//
//  Created by Garric Nahapetian on 10/18/16.
//
//

import Foundation

public class Observable<T> {
    public typealias Closure = ((T) -> Void)?

    private var closures: [Closure] = []

    public init() {}

    public func onNext(perform closure: Closure) {
        self.closures.append(closure)
    }

    public func emit(event: T) {
        closures.forEach { emit in
            emit?(event)
        }
    }
}
