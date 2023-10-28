//
//  GetData.swift
//  SendlerPhoto
//
//  Created by Vlad Kugan on 28.10.23.
//

import Foundation

var selectedItemId: Int?

// MARK: - Welcome
struct Welcome: Codable {
    let page, pageSize, totalPages, totalElements: Int
    let content: [Content]
}

// MARK: - Content
struct Content: Codable {
    let id: Int
    let name: String
    let image: String?
}
