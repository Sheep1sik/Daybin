//
//  CellView.swift
//  Daybin
//
//  Created by 양원식 on 4/17/24.
//

import SwiftUI

struct CellView: View {
    var day: Int
    var clicked: Bool = false
    
    init(day: Int, clicked: Bool) {
        self.day = day
        self.clicked = clicked
    }
    
    var body: some View {
        VStack {
            ZStack {
                if clicked {
                    Circle()
                        .foregroundColor(Color("CircleGray"))
                        .frame(width: 37, height: 37)
                }
                RoundedRectangle(cornerRadius: 5)
                    .opacity(0)
                    .overlay(Text(String(day)))
                    .foregroundColor(.black)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
            }
        }
    }
}
#Preview {
    CellView(day: 10, clicked: true)
}
