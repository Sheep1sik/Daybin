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
    var body: some View {
        CalenderView()
        
        Spacer()
        
        
        TodoView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .frame(height: 240)
    }
}
#Preview {
    return ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
