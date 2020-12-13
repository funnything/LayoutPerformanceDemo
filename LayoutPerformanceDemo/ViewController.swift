//
//  ViewController.swift
//  LayoutPerformanceDemo
//
//  Created by Yosaku Toyama on 2020/12/11.
//

import Cartography
import UIKit

class ViewController: UIViewController {
    override func loadView() {
        super.loadView()

        let stack = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 32

            view.addSubview($0)
            constrain($0) { v in
                v.center == v.sv.center
            }
        }

        _ = UIButton(type: .system).then {
            $0.addAction(.init(handler: { [unowned self] _ in
                self.navigationController!.pushViewController(AutoLayoutViewController(), animated: true)
            }), for: .touchUpInside)
            $0.setTitle("AutoLayout", for: .normal)
            stack.addArrangedSubview($0)
        }

        _ = UIButton(type: .system).then {
            $0.addAction(.init(handler: { _ in
                self.navigationController!.pushViewController(ManualLayoutViewController(), animated: true)
            }), for: .touchUpInside)
            $0.setTitle("ManualLayout", for: .normal)
            stack.addArrangedSubview($0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "🎄"
    }
}
