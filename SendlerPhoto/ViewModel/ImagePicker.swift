//
//  ImagePicker.swift
//  SendlerPhoto
//
//  Created by Vlad Kugan on 28.10.23.
//

import UIKit


class ImagePicker : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let imagePicker = UIImagePickerController()
    let developerFIO = Developer()
    
    func setupImagePicker(){
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let originalImage = info[.originalImage] as? UIImage {
            if let selectedItemId = selectedItemId {
                let developer = Developer()
                let developerName = developer.getFIO()

                if let imageData = originalImage.pngData() {
                    guard let serverURL = URL(string: "https://junior.balinasoft.com/api/v2/photo") else {
                        print("Invalid server URL")
                        return
                    }
                    var request = URLRequest(url: serverURL)
                    request.httpMethod = "POST"
                    
                    // Создайте тело запроса в формате multipart/form-data
                    var requestBody = Data()
                    let boundary = "Boundary-\(UUID().uuidString)"
                    let contentType = "multipart/form-data; boundary=\(boundary)"
                    
                    request.setValue(contentType, forHTTPHeaderField: "Content-Type")
                    
                    // Добавьте данные о разработчике и фотографию в тело запроса
                    requestBody.append("--\(boundary)\r\n".data(using: .utf8)!)
                    requestBody.append("Content-Disposition: form-data; name=\"name\"\r\n\r\n".data(using: .utf8)!)
                    requestBody.append("\(developerName)\r\n".data(using: .utf8)!)
                    
                    requestBody.append("--\(boundary)\r\n".data(using: .utf8)!)
                    requestBody.append("Content-Disposition: form-data; name=\"photo\"; filename=\"photo.png\"\r\n".data(using: .utf8)!)
                    requestBody.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
                    requestBody.append(imageData)
                    requestBody.append("\r\n".data(using: .utf8)!)
                    
                    requestBody.append("--\(boundary)\r\n".data(using: .utf8)!)
                    requestBody.append("Content-Disposition: form-data; name=\"typeId\"\r\n\r\n".data(using: .utf8)!)
                    requestBody.append("\(selectedItemId)\r\n".data(using: .utf8)!)
                    
                    requestBody.append("--\(boundary)--\r\n".data(using: .utf8)!)
                    
                    request.httpBody = requestBody
                    
                    
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        if let error = error {
                            print("Error: \(error)")
                        } else if let data = data {
                            let responseString = String(data: data, encoding: .utf8)
                            print("Response: \(responseString ?? "")")
                        }
                    }
                    
                    task.resume()
                } else {
                    print("Error converting image to data")
                }
            } else {
                print("Error: selectedItemId is nil")
            }
        } else {
            print("Error: Image not selected")
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}

class CustomImagePickerController: UIImagePickerController {
    var customUserInfo: [String: Any]?
}
