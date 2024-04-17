//
//  ContentView.swift
//  Daybin
//
//  Created by 양원식 on 4/17/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var isPresented = true
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(content: {
                    CalendarView()
                    Spacer()
                })
            }
        }
    }
}
#Preview {
    ContentView()
}
