//
//  TodoView.swift
//  Daybin
//
//  Created by 양원식 on 4/22/24.
//

import SwiftUI

struct TodoView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.todo, ascending: true)],
        animation: .default)
    private var todos: FetchedResults<Todo>
    
    @State var addItemButton: Bool = false
    @State var addTodo: String = ""
    
    var body: some View {
        VStack {
            HStack{
                Text("to do list")
                    .font(.title)
                    .padding(.leading, 1)
                Spacer()
                
                Button(action: {
                    addItemButton.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.gray)
                })
            }
            .padding(.leading, 15)
            .padding(.trailing, 18)
            // 수평 선
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color("ColorGray"))
            List {
                if !todos.isEmpty {
                    ForEach(self.todos, id: \.self) { todo in
                        TodoItemView(todoTitle: todo.todo ?? "제목 없음")
                    }
                    .onDelete(perform: deleteItems)
                }
                if addItemButton {
                    AddTodoItemView(addTodo: $addTodo, addItemButton: $addItemButton)
                }
            }
            .padding(.top, -7)
            .listStyle(.plain)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { todos[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none 
    return formatter
}()

#Preview {
    return TodoView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
