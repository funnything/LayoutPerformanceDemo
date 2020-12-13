//
//  AutoLayoutViewController.swift
//  LayoutPerformanceDemo
//
//  Created by Yosaku Toyama on 2020/12/13.
//

import Cartography
import UIKit

func hstack(spacing: CGFloat? = nil) -> UIStackView {
    UIStackView().then {
        $0.axis = .horizontal
        if let spacing = spacing {
            $0.spacing = spacing
        }
    }
}

func vstack(spacing: CGFloat? = nil) -> UIStackView {
    UIStackView().then {
        $0.axis = .vertical
        if let spacing = spacing {
            $0.spacing = spacing
        }
    }
}

class AutoLayoutViewController: UIViewController {
    var stopwatch: Stopwatch?

    override func loadView() {
        super.loadView()

        stopwatch = Stopwatch()

        view.backgroundColor = .systemBackground

        let scroll = UIScrollView().then {
            view.addSubview($0)
            constrain($0) { $0.matchParent() }
        }

        let stack = vstack(spacing: 30).then {
            scroll.addSubview($0)
            constrain($0) { v in
                v.centerX == v.sv.centerX
                v.top == v.sv.top + 20
                v.bottom == v.sv.bottom - 20
            }
        }

        (Consts.yearFrom...Consts.yearTo).forEach {
            stack.addArrangedSubview(constructYearView($0))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "AutoLayout"
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stopwatch!.split()
    }

    func constructYearView(_ year: Int) -> UIView {
        let v = vstack(spacing: 25)

        _ = UILabel().then {
            $0.font = UIFont.systemFont(ofSize: 32, weight: .bold)
            $0.text = "\(year)年"
            v.addArrangedSubview($0)
            v.setCustomSpacing(30, after: $0)
        }

        4.times { y in
            let row = hstack(spacing: 12).then {
                v.addArrangedSubview($0)
            }
            3.times { x in
                row.addArrangedSubview(constructMonthView(SimpleDate(year: year, month: y * 3 + x + 1, day: 1)))
            }
        }

        return v
    }

    func constructMonthView(_ startOfMonth: SimpleDate) -> UIView {
        let v = vstack()

        _ = UILabel().then {
            $0.text = "\(startOfMonth.month)月"
            $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            v.addArrangedSubview($0)
            v.setCustomSpacing(8, after: $0)
        }

        constructDateRows(startOfMonth, v)

        return v
    }

    func constructDateRows(_ startOfMonth: SimpleDate, _ v: UIStackView) {
        6.times { y in
            let row = hstack().then {
                v.addArrangedSubview($0)
            }
            7.times { x in
                let cell = UIView().then {
                    row.addArrangedSubview($0)
                    constrain($0) { v in
                        v.width == 15
                        v.height == 17
                    }
                }

                let index = y * 7 + x
                let date = startOfMonth.add(days: index - startOfMonth.weekday)
                if date.month == startOfMonth.month {
                    _ = UILabel().then {
                        $0.font = UIFont.systemFont(ofSize: 9)
                        $0.textColor = .label
                        $0.text = "\(date.day)"
                        cell.addSubview($0)
                        constrain($0) { v in
                            v.center == v.sv.center
                        }
                    }
                }
            }
        }
    }
}
