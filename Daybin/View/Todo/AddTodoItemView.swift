//
//  AddTodoItemView.swift
//  Daybin
//
//  Created by 양원식 on 5/7/24.
//

import SwiftUI

struct AddTodoItemView: View {
    @Binding var addTodo: String
    @Binding var addItemButton: Bool
    @Binding var userCalenderDate: String
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
                    .frame(width: 300)
                    .submitLabel(.done)
                    .autocorrectionDisabled(true)
                    .onSubmit {
                        if addTodo == "" {
                            showingAlert = true
                        } else {
                            addItem()
                            addItemButton = !addItemButton
                            addTodo = ""
                            showingAlert = false
                        }
                    }
                Spacer()
                Button(action: {
                }, label: {
                    Image(systemName: "circle")
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
            newItem.calenderDay = userCalenderDate
            
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
    AddTodoItemView(addTodo: .constant(""), addItemButton: .constant(true), userCalenderDate: .constant("2024-04-24"))
}
