//
//  PhotoDetails.swift
//  UITableViewCell05
//
//  Created by Nick Rodriguez on 15/08/2023.
//

import Foundation

class InterestingPhotosResponse: Codable{
    let title:String
    let url_z: URL?
}


class PhotoDetails: Codable {
    
    let title: String
    let remoteURL: URL?
    let photoID: String
    let dateTaken: Date
    
    enum CodingKeys: String, CodingKey {
        case title
        case remoteURL = "url_z"
        case photoID = "id"
        case dateTaken = "datetaken"
    }
}

extension PhotoDetails: Equatable {
    static func == (lhs: PhotoDetails, rhs: PhotoDetails) -> Bool {
        // Two Photos are teh same if they have the same photoID
        return lhs.photoID == rhs.photoID
    }
}
