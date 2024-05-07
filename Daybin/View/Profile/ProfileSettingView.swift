//
//  ProfileSettingView.swift
//  Daybin
//
//  Created by 양원식 on 5/7/24.
//

import SwiftUI

struct ProfileSettingView: View {
    @Binding var profileImage: UIImage?
    @State private var showImagePicker: Bool = false
    @Binding var isSettingsViewPresented: Bool
    
    var body: some View {
        VStack {
            if let image = profileImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .foregroundColor(.gray)
            }
            
            Button(action: {
                showImagePicker = true
            }, label: {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("ColorGray"))
                    .frame(width: 200, height: 50)
                    .overlay(
                        Text("이미지 변경")
                            .foregroundColor(.black)
                    )
            })
            .padding(.top, 30)
            .sheet(isPresented: $showImagePicker) {
                // 이미지 피커를 시트 형태로 표시
                ProfileImagePicker(image: self.$profileImage)
            }
        }
    }
    
}

#Preview {
    ProfileSettingView(profileImage: .constant(UIImage(named: "person.circle")), isSettingsViewPresented: .constant(true))
}
