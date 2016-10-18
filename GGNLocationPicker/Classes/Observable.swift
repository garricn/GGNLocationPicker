//
//  Observable.swift
//  Pods
//
//  Created by Garric Nahapetian on 10/14/16.
//
//

class Observable<T> {
    typealias Closure = ((T) -> Void)?
    var closures: [Closure] = []

    func onNext(perform closure: Closure) {
        self.closures.append(closure)
    }

    func emit(event: T) {
        closures.forEach { emit in
            emit?(event)
        }
    }
}
