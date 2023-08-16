//
//  FlickrStore.swift
//  UITableViewCell05
//
//  Created by Nick Rodriguez on 15/08/2023.
//

import UIKit

enum FlickrStoreError: Error{
    case failedToDownloadInterestingImageDetiails
    case failedToDownloadImage
    
    var localizedDescription: String {
        switch self {
        default: return "Error connecting to Flickr API"
        }
    }
}


class FlickrStore {
    var requestStore:RequestStore!
    
    func fetchInterestingPhotosEndpoint(completion: @escaping (Result<FlickrResponse, Error>) -> Void) {
        let dictBody = [
            "format": "json",
            "nojsoncallback": "1",
            "per_page": "10",
            "page": "1",
            "extras": "url_z,date_taken"
        ]
        
        let request = requestStore.createRequestFlickr(dictBody: dictBody)
        
        let task = requestStore.session.dataTask(with:request) { data, response, error in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let jsonPosts = try jsonDecoder.decode(FlickrResponse.self, from:data)
                    OperationQueue.main.addOperation {
                        completion(.success(jsonPosts))
                    }

                } catch {
                    print("- FlickrStoreError.fetchInterestingPhotosEndpoint Error receiving response")
                    OperationQueue.main.addOperation {
                        completion(.failure(FlickrStoreError.failedToDownloadInterestingImageDetiails))
                    }
                }
            }
            if let resp = response as? HTTPURLResponse{
                print(resp.statusCode)
            }
        }
        task.resume()
    }

    
    func fetchImageFromWeb(imgURL:URL,completion:@escaping(Result<UIImage,Error>)->Void){

        let request = URLRequest(url: imgURL)
        let task = requestStore.session.dataTask(with: request) { data, response, error in
            if let data = data{
                OperationQueue.main.addOperation {
                    let uiImage = UIImage(data: data)
                    completion(.success(uiImage!))
                }
            } else {
                OperationQueue.main.addOperation {
                    completion(.failure(FlickrStoreError.failedToDownloadImage))
                }
            }
        }
        task.resume()
    }
}

struct FlickrResponse: Codable {
    let photosInfo: FlickrPhotosResponse
    
    enum CodingKeys: String, CodingKey {
        case photosInfo = "photos"
    }
}

struct FlickrPhotosResponse: Codable {
    let photos: [InterestingPhotosResponse]
    
    enum CodingKeys: String, CodingKey {
        case photos = "photo"
    }
}
