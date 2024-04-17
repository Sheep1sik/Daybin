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
            
            CalendarGridView(date: date) // CalendarGridView에 date 전달
            
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
