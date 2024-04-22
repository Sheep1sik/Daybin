//
//  DaybinApp.swift
//  Daybin
//
//  Created by 양원식 on 4/22/24.
//

import SwiftUI

@main
struct DaybinApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
