//
//  CalenderItemView.swift
//  Daybin
//
//  Created by 양원식 on 5/7/24.
//

import SwiftUI

struct CalenderItemView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .foregroundColor(Color.clear)
            .padding(.top, 20)
            .padding(.bottom, 20)
    }
}

#Preview {
    CalenderItemView()
}
