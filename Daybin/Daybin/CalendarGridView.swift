//
//  CalendarGridView.swift
//  Daybin
//
//  Created by 양원식 on 4/17/24.
//

import SwiftUI

struct CalendarGridView: View {
    var body: some View {
        let daysInMonth: Int = numberOfDays(in: month)
            let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 1

            return VStack {
              LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                ForEach(0 ..< daysInMonth + firstWeekday, id: \.self) { index in
                  if index < firstWeekday {
                    RoundedRectangle(cornerRadius: 5)
                      .foregroundColor(Color.clear)
                  } else {
                    let date = getDate(for: index - firstWeekday)
                    let day = index - firstWeekday + 1
                    let clicked = clickedDates.contains(date)
                    
                    CellView(day: day, clicked: clicked)
                      .onTapGesture {
                        if clicked {
                          clickedDates.remove(date)
                        } else {
                          clickedDates.insert(date)
                        }
                      }
                  }
                }
              }
            }
          }
    }
}

#Preview {
    CalendarGridView()
}
