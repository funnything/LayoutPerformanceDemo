//
//  ManualLayoutViewController.swift
//  LayoutPerformanceDemo
//
//  Created by Yosaku Toyama on 2020/12/13.
//

import UIKit

class ManualLayoutViewController: UIViewController {
    var stopwatch: Stopwatch?

    override func loadView() {
        super.loadView()
        
        stopwatch = Stopwatch()

        view.backgroundColor = .systemBackground

        let sw = UIScreen.main.bounds.width
        let sh = UIScreen.main.bounds.height

        let scroll = UIScrollView().then {
            view.addSubview($0)
            $0.frame = CGRect(x: 0, y: 0, width: sw, height: sh)
        }

        var py: CGFloat = 20
        (Consts.yearFrom...Consts.yearTo).forEach {
            if $0 != Consts.yearFrom {
                py += 30
            }
            let w: CGFloat = 15 * 7 * 3 + 12 * 2
            constructYearView($0, scroll, (sw - w) / 2, &py)
        }
        py += 20

        scroll.contentSize = CGSize(width: sw, height: py)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ManualLayout"
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stopwatch!.split()
    }

    func constructYearView(_ year: Int, _ v: UIView, _ dx: CGFloat, _ py: inout CGFloat) {
        _ = UILabel().then {
            $0.font = UIFont.systemFont(ofSize: 32, weight: .bold)
            $0.text = "\(year)年"
            v.addSubview($0)
            let size = $0.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
            $0.frame = CGRect(x: dx, y: py, width: size.width, height: size.height)
            py += size.height + 30
        }

        4.times { y in
            if y != 0 {
                py += 25
            }

            var px = dx
            let pyForRow = py

            3.times { x in
                if x != 0 {
                    px += 12
                }
                py = pyForRow
                constructMonthView(SimpleDate(year: year, month: y * 3 + x + 1, day: 1), v, &px, &py)
            }
        }
    }

    func constructMonthView(_ startOfMonth: SimpleDate, _ v: UIView, _ px: inout CGFloat, _ py: inout CGFloat) {
        _ = UILabel().then {
            $0.text = "\(startOfMonth.month)月"
            $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)

            v.addSubview($0)
            let size = $0.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
            $0.frame = CGRect(x: px, y: py, width: size.width, height: size.height)
            py += size.height + 8
        }

        constructDateRows(startOfMonth, v, &px, &py)
    }

    func constructDateRows(_ startOfMonth: SimpleDate, _ v: UIView, _ px: inout CGFloat, _ py: inout CGFloat) {
        let pxForRows = px

        6.times { y in
            px = pxForRows
            7.times { x in
                let index = y * 7 + x
                let date = startOfMonth.add(days: index - startOfMonth.weekday)
                if date.month == startOfMonth.month {
                    _ = UILabel().then {
                        $0.textAlignment = .center
                        $0.font = UIFont.systemFont(ofSize: 9)
                        $0.textColor = .label
                        $0.text = "\(date.day)"
                        v.addSubview($0)
                        $0.frame = CGRect(x: px, y: py, width: 15, height: 17)
                    }
                }
                px += 15
            }
            py += 17
        }
    }
}
