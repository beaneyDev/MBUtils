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
    
    //// Run sth. after n secs
    open static func delay(_ secs: Float, task: @escaping Work) {
        if secs == 0 {
            task()
        } else {
            let queue = Thread.isMainThread ? DispatchQueue.main : DispatchQueue.global(qos: .default)
            queue.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(Int(secs * 1000)), execute: task)
        }
    }
}
