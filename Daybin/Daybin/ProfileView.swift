//
//  ProfileView.swift
//  Daybin
//
//  Created by 양원식 on 4/17/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        Image("Profile")
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .frame(width: 48, height: 48)
    }
}

#Preview {
    ProfileView()
}
