//
//  ContentView.swift
//  Daybin
//
//  Created by 양원식 on 5/7/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var userCalenderDate: String = ContentView.userDateFormatter.string(from: Date())
    
    var body: some View {
        ZStack {
            CalenderView(userCalenderDate: $userCalenderDate).environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            
            TodoScrollView(userCalenderDate: $userCalenderDate).environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            
        }
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
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
