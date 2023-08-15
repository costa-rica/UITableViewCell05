//
//  URLStore.swift
//  UITableViewCell05
//
//  Created by Nick Rodriguez on 14/08/2023.
//

import UIKit

enum APIBase:String, CaseIterable {
    case local = "localhost"
    case flickr = "flickr"
    var urlString:String {
        switch self{
        case .local: return "http://127.0.0.1:5002/"
        case .flickr: return "https://api.flickr.com/services/rest"
        }
    }
}

enum EndPoint: String {
    case interestingPhotos = "flickr.interestingness.getList"
}

enum RequestStoreError: Error{
    case failedToReceiveImage
    
    var localizedDescription: String {
        switch self {
        default: return "Error calling API"
        }
    }
}

class URLStore {
    
    var apiBase:APIBase!
    
    func createUrl(endPoint: EndPoint) -> URL{
        let baseURLString = apiBase.urlString + endPoint.rawValue
        let components = URLComponents(string:baseURLString)!
        return components.url!
    }
    func createUrlWithQueryStringDict(endPoint:EndPoint, queryStringDict:[String:String]) -> URL{
        var urlString = apiBase.urlString + endPoint.rawValue
        for element in queryStringDict {
            urlString = urlString + "/\(element.value)"
        }
        let components = URLComponents(string:urlString)!
        return components.url!
    }
}

