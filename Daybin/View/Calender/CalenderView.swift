//
//  CalenderView.swift
//  Daybin
//
//  Created by 양원식 on 5/7/24.
//

import SwiftUI

struct CalenderView: View {
    // MARK: - PROPERTY
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.calenderDay, ascending: true)],
        animation: .default)
    private var todos: FetchedResults<Todo>
    
    @State var date = Date()
    
    @Binding var userCalenderDate: String
    
    
    
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            CalenderHeaderView(date: $date, userCalendarDate: $userCalenderDate)
            
            WeekdayHeaderView()
            
            Rectangle()
                .frame(height: 1)
            
            CalenderGridView(date: $date, userCalenderDate: $userCalenderDate)
            
            Spacer()
            
            Rectangle()
                .frame(height: 1)
        }
        .padding(.leading, 15)
        .padding(.trailing, 15)
        
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
    
    
}
#Preview {
    CalenderView(userCalenderDate: .constant("2024-04-24")).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
