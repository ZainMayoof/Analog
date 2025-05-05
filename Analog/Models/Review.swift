//
//  Review.swift
//  Analog
//
//  Created by zain Mayoof on 18/04/2025.
//

import Foundation
import FirebaseFirestoreSwift

struct Review: Identifiable, Codable {
    @DocumentID var id: String?
    
    var storeID: String?
    var albumID: String?  
    
    var userID: String
    var userEmail: String
    var rating: Int
    var comment: String
    var timestamp: Date
}

