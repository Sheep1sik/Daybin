//
//  AddTodoItemView.swift
//  Daybin
//
//  Created by 양원식 on 4/23/24.
//

import SwiftUI

struct AddTodoItemView: View {
    
    @Binding var addTodo: String
    @Binding var addItemButton: Bool
    @State private var showingAlert = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.todo, ascending: true)],
        animation: .default)
    private var todos: FetchedResults<Todo>
    
    var body: some View {
        if addItemButton {
            HStack {
                TextField("to-do", text: $addTodo)
                    .disableAutocorrection(false)
                    .frame(width: 300)
                Spacer()
                Button(action: {
                    if addTodo == "" {
                        showingAlert = true
                    } else {
                        addItem()
                        addItemButton = !addItemButton
                        addTodo = ""
                        showingAlert = false
                    }
                }, label: {
                    Image(systemName: "checkmark.square.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color("ColorGray"))
                })
                .alert(isPresented: $showingAlert, content: {
                    Alert(title: Text("내용을 입력해 주세요."), message: nil, dismissButton: .default(Text("확인")))
                })
            }
            .padding(.top, 7)
            .padding(.bottom, 7)
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Todo(context: viewContext)
            newItem.id = UUID()
            newItem.todo = addTodo
            newItem.calendarDay = "2024-04-23"
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    AddTodoItemView(addTodo: .constant(""), addItemButton: .constant(true))
}
