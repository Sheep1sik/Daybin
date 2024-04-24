//
//  CalenderView.swift
//  Daybin
//
//  Created by 양원식 on 4/23/24.
//

import SwiftUI

struct CalenderView: View {
    // MARK: - PROPERTY
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.todo, ascending: true)],
        animation: .default)
    private var todos: FetchedResults<Todo>
    
    @State var date = Date()
    @State private var todayDate = Date()
    @State private var offset: CGSize = CGSize()
    @State var clickedDates: Set<Date> = []
    @State var clickDay = false
    @State var today = true
    
    @Binding var userCalenderDate: String
    
    
    // MARK: - FUNCTION
    
    private var daysInMonth: Int {
        return numberOfDays(in: date)
    }
    
    private var firstWeekday: Int {
        return firstWeekdayOfMonth(in: date) - 1
    }
    
    
    
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            HStack {
                // 프로필
                Image("Profile")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                
                Spacer()
                
                Button(action: {
                    print("left")
                    changeMonth(by: -1)
                }, label: {
                    Image(systemName: "chevron.left")
                })
                .foregroundColor(.gray)
                
                Text(date, formatter: CalenderView.calenderTitleDateFormatter)
                    .font(.title3)
                
                Button(action: {
                    print("right")
                    changeMonth(by: 1)
                }, label: {
                    Image(systemName: "chevron.right")
                })
                .foregroundColor(.gray)
            }
            .padding(.bottom, 15)
            HStack {
                ForEach(Self.weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .frame(maxWidth: .infinity)
                }
            }
            Rectangle()
                .frame(height: 1)
            
            VStack {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 7), content: {
                    ForEach(0 ..< daysInMonth + firstWeekday, id: \.self) { index in
                        if index < firstWeekday {
                            ZStack {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.clear)
                                    CalenderItemView()
                                }
                                Circle()
                                    .frame(width: 7,height: 7)
                                    .foregroundColor(.clear)
                                    .padding(.top, 60)
                            }
                            
                        } else {
                            let getDate = getDate(for: index - firstWeekday)
                            let day = index - firstWeekday + 1
                            let clicked = clickedDates.contains(getDate)
                            
                            if dateValidation() && day == Calendar.current.component(.day, from: todayDate){
                                if today {
                                    ZStack {
                                        ZStack {
                                            Circle()
                                                .foregroundColor(.gray)
                                            CalenderItemView()
                                                .overlay(
                                                    Text(String(day))
                                                        .fontWeight(.bold)
                                                        .foregroundColor(.white)
                                                )
                                        }
                                        if todoValidation(for: day) {
                                            Circle()
                                                .frame(width: 7,height: 7)
                                                .foregroundColor(Color("ColorGray"))
                                                .padding(.top, 60)
                                        }
                                        else {
                                            Circle()
                                                .frame(width: 7,height: 7)
                                                .foregroundColor(.clear)
                                                .padding(.top, 60)
                                        }
                                    }
                                    .padding(.top, -15)
                                            .onTapGesture {
                                                if !clicked {
                                                    userCalenderDate = CalenderView.userDateFormatter.string(from: date)+String(day)
                                                    today = false
                                                    clickedDates.removeAll()
                                                    clickedDates.insert(getDate)
                                                }
                                            }
                                }
                                else {
                                    if clicked {
                                        ZStack {
                                            ZStack {
                                                Circle()
                                                    .foregroundColor(.gray)
                                                CalenderItemView()
                                                    .overlay(
                                                        Text(String(day))
                                                            .fontWeight(.bold)
                                                            .foregroundColor(.white)
                                                    )
                                            }
                                            if todoValidation(for: day) {
                                                Circle()
                                                    .frame(width: 7,height: 7)
                                                    .foregroundColor(Color("ColorGray"))
                                                    .padding(.top, 60)
                                            }
                                            else {
                                                Circle()
                                                    .frame(width: 7,height: 7)
                                                    .foregroundColor(.clear)
                                                    .padding(.top, 60)
                                            }
                                        }
                                        .padding(.top, -15)
                                                .onTapGesture {
                                                    if !clicked {
                                                        userCalenderDate = CalenderView.userDateFormatter.string(from: date)+String(day)
                                                        today = false
                                                        clickedDates.removeAll()
                                                        clickedDates.insert(getDate)
                                                    }
                                                }
                                    } else {
                                        ZStack {
                                            ZStack {
                                                Circle()
                                                    .foregroundColor(.clear)
                                                CalenderItemView()
                                                    .overlay(
                                                        Text(String(day))
                                                            .fontWeight(.bold)
                                                    )
                                            }
                                            if todoValidation(for: day) {
                                                Circle()
                                                    .frame(width: 7,height: 7)
                                                    .foregroundColor(Color("ColorGray"))
                                                    .padding(.top, 60)
                                            }
                                            else {
                                                Circle()
                                                    .frame(width: 7,height: 7)
                                                    .foregroundColor(.clear)
                                                    .padding(.top, 60)
                                            }
                                        }
                                        .padding(.top, -15)
                                            .onTapGesture {
                                                if !clicked {
                                                    userCalenderDate = CalenderView.userDateFormatter.string(from: date)+String(day)
                                                    today = false
                                                    clickedDates.removeAll()
                                                    clickedDates.insert(getDate)
                                                }
                                            }
                                    }

                                }
                            } else {
                                if clicked {
                                    ZStack {
                                        ZStack {
                                            Circle()
                                                .foregroundColor(.gray)
                                            CalenderItemView()
                                                .overlay(
                                                    Text(String(day))
                                                        .fontWeight(.bold)
                                                        .foregroundColor(.white)
                                                )
                                        }
                                        if todoValidation(for: day) {
                                            Circle()
                                                .frame(width: 7,height: 7)
                                                .foregroundColor(Color("ColorGray"))
                                                .padding(.top, 60)
                                        } else {
                                            Circle()
                                                .frame(width: 7,height: 7)
                                                .foregroundColor(.clear)
                                                .padding(.top, 60)
                                        }
                                    }
                                    .padding(.top, -15)
                                            .onTapGesture {
                                                if !clicked {
                                                    userCalenderDate = CalenderView.userDateFormatter.string(from: date)+String(day)
                                                    today = false
                                                    clickedDates.removeAll()
                                                    clickedDates.insert(getDate)
                                                }
                                            }
                                    } else {
                                    ZStack {
                                        ZStack {
                                            Circle()
                                                .foregroundColor(.clear)
                                            CalenderItemView()
                                                .overlay(
                                                    Text(String(day))
                                                )
                                        }
                                        if todoValidation(for: day) {
                                            Circle()
                                                .frame(width: 7,height: 7)
                                                .foregroundColor(Color("ColorGray"))
                                                .padding(.top, 60)
                                        } else {
                                            Circle()
                                                .frame(width: 7,height: 7)
                                                .foregroundColor(.clear)
                                                .padding(.top, 60)
                                        }
                                    }
                                    .padding(.top, -15)
                                        .onTapGesture {
                                            if !clicked {
                                                userCalenderDate = CalenderView.userDateFormatter.string(from: date)+String(day)
                                                today = false
                                                clickedDates.removeAll()
                                                clickedDates.insert(getDate)
                                            }
                                        }
                                    
                                }
                            }
                        }
                    }
                })
            }
            
            Spacer()
            
            Rectangle()
                .frame(height: 1)
        }
        .padding(.leading, 15)
        .padding(.trailing, 15)
        
    }
}

private extension CalenderView {
    
    private func todoValidation(for day: Int) -> Bool {
        return todos.contains { $0.calenderDay == CalenderView.userDateFormatter.string(from: date)+String(day)}
    }
    
    private func dateValidation() -> Bool {
        return Calendar.current.isDate(todayDate, equalTo: date, toGranularity: .year) &&
        Calendar.current.isDate(todayDate, equalTo: date, toGranularity: .month)
    }
    
    /// 특정 해당 날짜
    private func getDate(for day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: startOfMonth())!
    }
    
    /// 해당 월의 시작 날짜
    func startOfMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        return Calendar.current.date(from: components)!
    }
    
    /// 해당 월에 존재하는 일자 수
    func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    /// 해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
    
    /// 월 변경
    func changeMonth(by value: Int) {
        let calendar = Calendar.current
        if let newMonth = calendar.date(byAdding: .month, value: value, to: date) {
            self.date = newMonth
        }
    }
}

// MARK: - Static 프로퍼티
extension CalenderView {
    static let calenderTitleDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    static let userDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-"
        return formatter
    }()
    
    static let weekdaySymbols = Calendar.current.shortWeekdaySymbols
    
    
}

// MARK: - PREVIEW

#Preview {
    CalenderView(userCalenderDate: .constant("2024-04-24")).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
