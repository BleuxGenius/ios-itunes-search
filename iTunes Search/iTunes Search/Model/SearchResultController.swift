//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Lambda_School_Loaner_167 on 10/1/19.
//  Copyright © 2019 Dani. All rights reserved.
//

import Foundation

class SearchResultController {

var baseURL = URL(string: "https://itunes.apple.com/search?parameterkeyvalue")!

    var searchResults: [SearchResult] = []
    
    func performSearch(with searchTerm: String, resultType: ResultType, completionClosure: @escaping () -> Void ) {
        
//         Build out the URL
        
        var searchURL = baseURL.appendingPathComponent("searchResults")
        
        var components = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        
        components?.queryItems = [searchQueryItem]
        
        guard let requestURL = components?.url else {
            completionClosure()
            return
        }
//            Create a URLRequest
            var request = URLRequest(url : requestURL)
            request.httpMethod = HTTPMethod.get.rawValue
        
//        Preform the request (with a data task)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            Handle ny errors
            if let error = error {
                NSLog("Error fetching search: \(error)")
                completionClosure()
                return
            }
//            (USUALLY decode data)
            
            guard let data = data else {
                NSLog("No data returned from search")
                completionClosure()
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let search = try decoder.decode(SearchResult.self, from: data)
                self.searchResults = [search.self]
                
            } catch {
                NSLog("Unable to decode data into search: \(error)")
            }
            completionClosure()
        }
//            this is what preforms the data task or gets it to go to the server
        dataTask.resume()
        
        }
        
    }

enum HTTPMethod: String {
    
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"


}
