//
//  CalendarView.swift
//  Daybin
//
//  Created by 양원식 on 4/17/24.
//

import SwiftUI

struct CalendarView: View {
    // MARK: - PROPERTY
    @State private var date = Date()
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
    
    /// 월 변경
    private func changeMonth(by value: Int) {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: date) {
            self.date = newMonth
        }
    }
    
    var body: some View {
        VStack {
            HStack(content: {
                // 프로필
                ProfileView()
                
                Spacer()
                
                // 월 년도
                Text(date, formatter: Self.dateFormatter)
                    .font(.title)
            })
            .padding(.leading, 15)
            .padding(.trailing, 15)
            .padding(.bottom, 10)
            
            // 요일
            HStack {
                ForEach(Self.lowercaseWeekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
            .padding(.bottom, 10)
            
            // 수평 선
            Rectangle()
                .frame(height: 2)
                .foregroundColor(Color("ColorGray"))
            
            calendarGridView
            
        }
        .gesture(
              DragGesture()
                .onChanged { gesture in
                  self.offset = gesture.translation
                }
                .onEnded { gesture in
                  if gesture.translation.width < -100 {
                    changeMonth(by: 1)
                  } else if gesture.translation.width > 100 {
                    changeMonth(by: -1)
                  }
                  self.offset = CGSize()
                }
            )
        
        
    }
    
    // MARK: - 날짜 그리드 뷰
    private var calendarGridView: some View {
        let daysInMonth: Int = numberOfDays(in: date)
        let firstWeekday: Int = firstWeekdayOfMonth(in: date) - 1
        
        return VStack {
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
    
    // MARK: - 일자 셀 뷰
    private struct CellView: View {
        var day: Int
        var clicked: Bool = false
        
        init(day: Int, clicked: Bool) {
            self.day = day
            self.clicked = clicked
        }
        
        var body: some View {
            VStack {
                ZStack {
                    if clicked {
                        Circle()
                            .foregroundColor(Color("CircleGray"))
                            .frame(width: 37, height: 37)
                    }
                    RoundedRectangle(cornerRadius: 5)
                        .opacity(0)
                        .overlay(Text(String(day)))
                        .foregroundColor(.black)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                }
            }
        }
    }

extension CalendarView {
    
    // 월 년도 표기
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    // 요일 표기
    static let lowercaseWeekdaySymbols: [String] = {
            var symbols = Calendar.current.shortWeekdaySymbols
            symbols = symbols.map { $0.lowercased() }
            return symbols
        }()
}

#Preview {
    CalendarView()
}
