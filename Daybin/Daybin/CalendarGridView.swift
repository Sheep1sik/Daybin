//
//  CalendarGridView.swift
//  Daybin
//
//  Created by 양원식 on 4/17/24.
//

import SwiftUI

struct CalendarGridView: View {
    var date: Date
    @State var offset: CGSize = CGSize()
    @State var clickedDates: Set<Date> = []
    
    private var daysInMonth: Int {
        return numberOfDays(in: date)
    }
    
    private var firstWeekday: Int {
        return firstWeekdayOfMonth(in: date) - 1
    }
    
    // MARK: - FUNCTION
    private func getDate(for day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: startOfMonth())!
    }
    
    /// 해당 월의 시작 날짜
    private func startOfMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        return Calendar.current.date(from: components)!
    }
    
    /// 해당 월에 존재하는 일자 수
    private func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    /// 해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일
    private func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        guard let firstDayOfMonth = Calendar.current.date(from: components) else {
            return 0
        }
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
    
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                ForEach(0 ..< daysInMonth + firstWeekday, id: \.self) { index in
                    if index < firstWeekday {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color.clear)
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                    } else {
                        let date = getDate(for: index - firstWeekday)
                        let day = index - firstWeekday + 1
                        let clicked = clickedDates.contains(date)
                        
                        CellView(day: day, clicked: clicked)
                            .onTapGesture {
                                if clicked {
                                    clickedDates.remove(date)
                                } else {
                                    clickedDates.removeAll()
                                    clickedDates.insert(date)
                                }
                            }
                    }
                }
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
        }
    }
}


#Preview {

    CalendarGridView(date: Date())
}
