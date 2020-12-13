//
//  SimpleDate.swift
//  LayoutPerformanceDemo
//
//  Created by Yosaku Toyama on 2020/12/13.
//

import Foundation

// ref. https://ja.wikipedia.org/wiki/ユリウス通日#西暦と修正ユリウス日との相互換算
struct SimpleDate {
    let year: Int
    let month: Int
    let day: Int

    var modifiedJulianDate: Int {
        let y = month < 3 ? year - 1 : year
        let m = month < 3 ? month + 12 : month
        let d = day

        return 36525 * y / 100 + y / 400 - y / 100 + 3059 * (m - 2) / 100 + d - 678912
    }

    // 0 for sunday, 6 for saturday
    var weekday: Int {
        (modifiedJulianDate + 3) % 7
    }

    var date: Date {
        Calendar.autoupdatingCurrent.date(from: DateComponents(year: year, month: month, day: day))!
    }

    init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
    }

    init(modifiedJulianDate mjd: Int) {
        let n = mjd + 678881
        let a = 4 * n + 3 + (4 * (n + 1) / 146097 + 1) * 3 / 4 * 4
        let b = a % 1461 / 4 * 5 + 2

        let y = a / 1461
        let m = b / 153 + 3
        let d = b % 153 / 5 + 1

        self.year = m > 12 ? y + 1 : y
        self.month = m > 12 ? m - 12 : m
        self.day = d
    }

    static func from(date: Date) -> SimpleDate {
        let cal = Calendar.autoupdatingCurrent
        return self.init(
            year: cal.component(.year, from: date),
            month: cal.component(.month, from: date),
            day: cal.component(.day, from: date)
        )
    }

    static func now() -> SimpleDate {
        from(date: Date())
    }

    func add(days: Int) -> SimpleDate {
        SimpleDate(modifiedJulianDate: modifiedJulianDate + days)
    }

    func sub(days: Int) -> SimpleDate {
        add(days: -days)
    }

    func daysSince(_ date: SimpleDate) -> Int {
        modifiedJulianDate - date.modifiedJulianDate
    }
}
