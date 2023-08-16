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



class URLStore {
    
    var apiBase:APIBase!
//    let apiKey = "23abc38f7ea8cf79c6c2ac75a0c06a42"
    var apiKey: String? {
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
            return dict["FLICKR_API_KEY"] as? String
        }
        return nil
    }
    
    func createUrl(endPoint: EndPoint) -> URL{
        let baseURLString = apiBase.urlString + endPoint.rawValue
        let components = URLComponents(string:baseURLString)!
        return components.url!
    }
    
    func createUrlWithComponentsForFlickr(dictBody:[String:String]) -> URL{
        var components = URLComponents(string: APIBase.flickr.urlString)!
        var queryItems = [URLQueryItem]()
        
        for (key, value) in dictBody {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        let itemApiKey = URLQueryItem(name: "api_key", value: apiKey)
        queryItems.append(itemApiKey)
        let itemApiEndpoint = URLQueryItem(name: "method", value: EndPoint.interestingPhotos.rawValue)
        queryItems.append(itemApiEndpoint)

        
        components.queryItems = queryItems
        return components.url!
    }
}

