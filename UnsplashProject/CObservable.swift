//
//  CObservable.swift
//  UnsplashProject
//
//  Created by 이현호 on 2022/10/28.
//

import Foundation

class CObservable<T> {
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
    
}

