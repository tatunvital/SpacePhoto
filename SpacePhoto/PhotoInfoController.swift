//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by Виталий Татун on 22.02.22.
//

import Foundation
import UIKit

class PhotoInfoController {
    
    enum PhotoInfoError: Error, LocalizedError {
        case itemNotFound
        case imageDataMissing
    }

    func fetchingPhotoInfo() async throws -> PhotoInfo {
        
        var urlComponets =  URLComponents(string: "https://api.nasa.gov/planetary/apod")!
        urlComponets.queryItems = [
            "api_key": "DEMO_KEY",
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        
        
        let (data, response) = try await URLSession.shared.data(from: urlComponets.url!)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else  {
                  throw PhotoInfoError.itemNotFound
              }
        
        let jsonDecoder = JSONDecoder()
        let photoInfo = try jsonDecoder.decode(PhotoInfo.self, from: data)
        return (photoInfo)
    }

    func fetchImage(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponce = response as? HTTPURLResponse,
              httpResponce.statusCode == 200 else {
                  throw PhotoInfoError.imageDataMissing
              }
        
        guard let image = UIImage(data: data) else {
            throw PhotoInfoError.imageDataMissing
        }
        return image
    }
    
    
}

