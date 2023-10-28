//
//  DeveloperData.swift
//  SendlerPhoto
//
//  Created by Vlad Kugan on 28.10.23.
//

import Foundation

class Developer{
    
    func getFIO() -> String{
        let developerFirstName = Bundle.main.object(forInfoDictionaryKey: "DevoloperFirstName") as? String ?? ""
        let developerLastName = Bundle.main.object(forInfoDictionaryKey: "DeveloperLastName") as? String ?? ""
        let developerSecondName = Bundle.main.object(forInfoDictionaryKey: "DeveloperSecondName") as? String ?? ""
        return "\(developerLastName) \(developerFirstName) \(developerSecondName)"
    }
}
