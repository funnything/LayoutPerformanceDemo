//
//  Int+Ex.swift
//  LayoutPerformanceDemo
//
//  Created by Yosaku Toyama on 2020/12/13.
//

extension Int {
    var times: Range<Int> { 0..<self }

    func times(_ body: (Int) throws -> Void) rethrows {
        try self.times.forEach(body)
    }
}
