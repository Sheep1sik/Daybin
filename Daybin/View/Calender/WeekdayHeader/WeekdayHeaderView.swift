//
//  WeekdayHeaderView.swift
//  Daybin
//
//  Created by 양원식 on 5/7/24.
//

import SwiftUI

struct WeekdayHeaderView: View {
    var body: some View {
        HStack {
            ForEach(Self.weekdaySymbols, id: \.self) { symbol in
                Text(symbol)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

extension WeekdayHeaderView {
    static let weekdaySymbols = Calendar.current.shortWeekdaySymbols
}

#Preview {
    WeekdayHeaderView()
}
