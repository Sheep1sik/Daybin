//
//  TodoScrollView.swift
//  Daybin
//
//  Created by 양원식 on 5/7/24.
//

import SwiftUI

struct TodoScrollView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var startingOffsetY: CGFloat = UIScreen.main.bounds.height
    @State private var currentDragOffsetY: CGFloat = 0
    @State private var endingOffsetY: CGFloat = -UIScreen.main.bounds.height * 0.37
    
    @Binding var userCalenderDate: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 35)
                .foregroundColor(.white)
                .shadow(color: .gray.opacity(0.25), radius: 3,x: 0, y: -4)
                .padding(.top, -7)
            VStack {
                RoundedRectangle(cornerRadius: 35)
                    .frame(width: 53, height: 4)
                    .foregroundColor(Color("ColorGray"))
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                withAnimation(.spring()) {
                                    currentDragOffsetY = value.translation.height
                                }
                            })
                            .onEnded({ value in
                                withAnimation(.spring()) {
                                    if currentDragOffsetY < -30 {
                                        endingOffsetY = -startingOffsetY * 0.87
                                        currentDragOffsetY = .zero
                                    } else if endingOffsetY != -400 && currentDragOffsetY > 20 {
                                        endingOffsetY = -UIScreen.main.bounds.height * 0.37
                                        currentDragOffsetY = .zero
                                    } else {
                                        currentDragOffsetY = .zero
                                    }
                                }
                            })
                    )
                TodoView(userCalenderDate: $userCalenderDate).environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                    .padding(.top, 10)
            } //: VSTACK
        } //: ZSTACK
        .offset(y: startingOffsetY + currentDragOffsetY + endingOffsetY)
        
    }
}

#Preview {
    TodoScrollView(userCalenderDate: .constant("2024-04-24")).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

