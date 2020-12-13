//
//  Stopwatch.swift
//  LayoutPerformanceDemo
//
//  Created by Yosaku Toyama on 2020/12/13.
//

import Foundation

class Stopwatch {
    var time: CFTimeInterval
    var sum: CFTimeInterval = 0
    var count = 0

    init() {
        time = CFAbsoluteTimeGetCurrent()
    }

    func output(level: Int, tag: Int, duration: CFTimeInterval, type: String, postfix: String = "") {
        let indent = String(repeating: "  ", count: level)
        let durationRepl = String(format: "%.3f", duration)
        print("\(indent)\(type) for \(tag): \(durationRepl)\(postfix)")
    }

    func split(_ level: Int = 0, tag: Int = #line) {
        let current = CFAbsoluteTimeGetCurrent()
        output(level: level, tag: tag, duration: current - time, type: "split")
        time = current
    }

    func begin() {
        time = CFAbsoluteTimeGetCurrent()
    }

    func end() {
        sum += CFAbsoluteTimeGetCurrent() - time
        count += 1
    }

    func sum(_ level: Int = 0, tag: Int = #line) {
        output(level: level, tag: tag, duration: sum, type: "sum", postfix: String(format: " in %d (%.3f sec/call)", count, sum / Double(count)))
    }
}
