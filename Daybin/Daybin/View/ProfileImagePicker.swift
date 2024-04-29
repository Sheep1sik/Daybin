//
//  ProfileImagePicker.swift
//  Daybin
//
//  Created by 양원식 on 4/29/24.
//

import SwiftUI
import UIKit

struct ProfileImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary // 갤러리에서 사진을 선택하도록 설정
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ProfileImagePicker

        init(_ parent: ProfileImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage // 선택한 이미지를 바인딩된 속성을 통해 전달
                saveImageToUserDefaults(image: uiImage) // 선택한 이미지를 저장
                parent.presentationMode.wrappedValue.dismiss() // 이미지 피커 닫기
            }
        }

        func saveImageToUserDefaults(image: UIImage) {
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                UserDefaults.standard.set(imageData, forKey: "profileImage")
            }
        }
    }

}

