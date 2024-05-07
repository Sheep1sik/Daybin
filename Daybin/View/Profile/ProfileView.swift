//
//  ProfileView.swift
//  Daybin
//
//  Created by 양원식 on 5/7/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var profileImage: UIImage?
    @State private var isSettingsViewPresented: Bool = false
    
    var body: some View {
        VStack {
            if let image = profileImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                    .onTapGesture {
                        isSettingsViewPresented = true
                    }
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                    .foregroundColor(.gray)
                    .onTapGesture {
                        isSettingsViewPresented = true
                    }
            }
        }
        .fullScreenCover(isPresented: $isSettingsViewPresented) {
            ZStack {
                // 배경이 투명한 뷰 추가
                Color.clear
                    .contentShape(Rectangle()) // 전체 영역에 대한 탭 제스처 설정
                ProfileSettingView(profileImage: $profileImage, isSettingsViewPresented: $isSettingsViewPresented)
            }
            .onTapGesture {
                isSettingsViewPresented = false
            }
        }
        
        .onAppear {
            // 앱이 실행될 때 저장된 이미지를 불러와서 표시
            if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
               let uiImage = UIImage(data: imageData) {
                self.profileImage = uiImage
            }
        }
        
        
    }
}
#Preview {
    ProfileView()
}
