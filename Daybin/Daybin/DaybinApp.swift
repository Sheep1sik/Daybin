//
//  DaybinApp.swift
//  Daybin
//
//  Created by 양원식 on 4/17/24.
//

import SwiftUI

@main
struct DaybinApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TodoView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

