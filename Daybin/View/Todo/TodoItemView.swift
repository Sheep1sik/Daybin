//
//  TodoItemView.swift
//  Daybin
//
//  Created by 양원식 on 5/7/24.
//

import SwiftUI

struct TodoItemView: View {
    @State private var todoChecked = false
    @State var todoTitle: String
    
    var body: some View {
        HStack{
            todoChecked ? Text(todoTitle).strikethrough() : Text(todoTitle)
            
            Spacer()
            
            Button(action: {
                print("\(todoChecked)")
                todoChecked = !todoChecked
            }, label: {
                
                Image(systemName: todoChecked ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color("ColorGray"))
            })
        } //: HSTACK
        .padding(.top, 7)
        .padding(.bottom, 7)
    }
}


#Preview {
    return TodoItemView(todoTitle: "빈이 생일 🐰")
}
