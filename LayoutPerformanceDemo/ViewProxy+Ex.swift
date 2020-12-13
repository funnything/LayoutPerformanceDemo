//
//  ViewProxy+Ex.swift
//  LayoutPerformanceDemo
//
//  Created by Yosaku Toyama on 2020/12/13.
//

import Cartography

extension ViewProxy {
    var sv: ViewProxy {
        guard let sv = superview else {
            fatalError("superview == nil")
        }
        return sv
    }

    func match(to anchor: ViewProxy) {
        top == anchor.top
        bottom == anchor.bottom
        leading == anchor.leading
        trailing == anchor.trailing
    }

    func matchParent() {
        match(to: sv)
    }
}
