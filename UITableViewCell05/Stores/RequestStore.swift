//
//  RequestStore.swift
//  UITableViewCell05
//
//  Created by Nick Rodriguez on 14/08/2023.
//

import UIKit
enum RequestStoreError: Error{
    case failedToReceiveImage
    
    var localizedDescription: String {
        switch self {
        default: return "Error calling API"
        }
    }
}
class RequestStore{
    
    var urlStore:URLStore!
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    private let fileManager:FileManager
    private let documentsURL:URL
    init() {
        urlStore = URLStore()
        self.fileManager = FileManager.default
        self.documentsURL = self.fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func createRequestFlickr(dictBody:[String:String])->URLRequest{
        let url = urlStore.createUrlWithComponentsForFlickr(dictBody:dictBody)
        let request = URLRequest(url:url)
        return request
    }
}
