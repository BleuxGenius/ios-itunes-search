//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Lambda_School_Loaner_167 on 10/1/19.
//  Copyright © 2019 Dani. All rights reserved.
//

import Foundation




struct SearchResult: Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case title = "trackName"
        case creator = "artistName"
        
    }
    
    let title: String
    let creator: String
}

struct SearchResults: Codable {
    
    let results: [SearchResult]
}
    
