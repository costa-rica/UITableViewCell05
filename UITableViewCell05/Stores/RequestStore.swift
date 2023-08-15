//
//  RequestStore.swift
//  UITableViewCell05
//
//  Created by Nick Rodriguez on 14/08/2023.
//

import UIKit

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
    
    
    func createRequest(endpoint:EndPoint, dictString:[String:String]?)->URLRequest{
        let url = urlStore.createUrl(endPoint: endpoint)
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        
        var combinedDict: [String: Any] = [:]
        
        // Add dictString data if present
        if let dict = dictString {
            for (key, value) in dict {
                combinedDict[key] = value
            }
        }
                
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: combinedDict, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error creating JSON data: \(error)")
        }
        
        return request
    }
}
