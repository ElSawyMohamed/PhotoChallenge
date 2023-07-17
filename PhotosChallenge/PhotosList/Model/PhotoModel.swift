//
//  PhotoModel.swift
//  PhotosChallenge
//
//  Created by Mohamed El Sawy on 15/07/2023.
//

import Foundation

// MARK: - PhotoModel
struct PhotoModel: Codable {
    let photos: Photos?
    let stat: String?
    let code: Int?
    let message: String?
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage, total: Int
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}
