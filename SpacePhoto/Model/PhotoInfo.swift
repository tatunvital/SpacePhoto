//
//  PhotoInfo.swift
//  SpacePhoto
//
//  Created by Виталий Татун on 22.02.22.
//

import Foundation

struct PhotoInfo: Codable {
    var title: String
    var description: String
    var url: URL
    var copyright: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation"
        case url
        case copyright
    }
}   
