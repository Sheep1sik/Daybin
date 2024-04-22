//
//  TodoItemView.swift
//  Daybin
//
//  Created by 양원식 on 4/22/24.
//

import SwiftUI

struct TodoItemView: View {
    @State private var todoChecked = false
    @State var todoTitle: String
    
    var body: some View {
        HStack{
            if todoChecked == false {
                Text(todoTitle)
            } else {
                Text(todoTitle).strikethrough()
            }
            
            Spacer()
            
            Button(action: {
                print("\(todoChecked)")
                todoChecked = !todoChecked
            }, label: {
                if todoChecked == false {
                    Image(systemName: "circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color("ColorGray"))
                } else {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color("ColorGray"))
                }
            })
        } //: HSTACK
        .padding(.top, 15)
        .padding(.bottom, 15)
        .padding(.trailing, 20)
    }
}


#Preview {
    return TodoItemView(todoTitle: "빈이 생일 🐰")
}
