//
//  on.swift
//  Pods
//
//  Created by Matt Beaney on 15/01/2017.
//
//

import Foundation

open class MBOn {
    static let STANDARD_ANIMATION_TIME = Float(0.3)
    
    public typealias Work = () -> ()
    
    /// Run sth. on the main thread - avoid dispatch overhead if already tehre
    open static func main(_ task: @escaping Work) {
        if Thread.isMainThread {
            task()
        } else {
            DispatchQueue.main.async(execute: task)
        }
    }
    
    /// Run sth. on a background thread
    open static func bg(_ task: @escaping Work) {
        DispatchQueue.global(qos: .default).async(execute: task)
    }
}
