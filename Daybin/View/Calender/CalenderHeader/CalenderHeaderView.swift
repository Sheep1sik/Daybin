//
//  CalenderHeaderView.swift
//  Daybin
//
//  Created by 양원식 on 5/7/24.
//

import SwiftUI

struct CalenderHeaderView: View {
    @Binding var date: Date
    @Binding var userCalendarDate: String
    
    func changeMonth(by value: Int) {
        let calendar = Calendar.current
        if let newMonth = calendar.date(byAdding: .month, value: value, to: date) {
            self.date = newMonth
        }
    }
    var body: some View {
        HStack {
            ProfileView()
            
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
    }
}

#Preview {
    CalenderHeaderView(date: .constant(Date()), userCalendarDate: .constant("2024-04-24"))
}
