//
//  ContentView.swift
//  Daybin
//
//  Created by 양원식 on 4/22/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var userCalenderDate: String = ContentView.userDateFormatter.string(from: Date())
    
    var body: some View {
        CalenderView(userCalenderDate: $userCalenderDate)
        
        Spacer()
        
        
        TodoView(userCalenderDate: $userCalenderDate).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .frame(height: 240)
        
    }
}

extension ContentView {
    static let userDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}

#Preview {
    return ContentView(userCalenderDate: "2024-04-24").environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
