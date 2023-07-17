//
//  NConstants.swift
//  PhotosChallenge
//
//  Created by Mohamed El Sawy on 15/07/2023.
//

import Foundation

class NConstants {
            
        
    static let PhotosChallengeUrl: String = "https://www.flickr.com"
        
    // endpoints
    static let photoSearch = "/services/rest/"


    // To concatenate Base URL and Endpoint
    static func endpoint(_ endpoint: String) -> URL {
        return "\(PhotosChallengeUrl)\(endpoint)".url
    }
}
