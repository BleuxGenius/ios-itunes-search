//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Lambda_School_Loaner_167 on 10/1/19.
//  Copyright © 2019 Dani. All rights reserved.
//

import Foundation

class SearchResultController {

var baseURL = URL(string: "https://itunes.apple.com/search")!

    var searchResults: [SearchResult] = []
    
    func performSearch(with searchTerm: String, resultType: ResultType, completionClosure: @escaping (Error?) -> Void ) {
        
//         Build out the URL
        
//        var searchURL = baseURL.appendingPathComponent("searchResults")
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
       
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let entityQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        components?.queryItems = [searchQueryItem, entityQueryItem]
        
        guard let requestURL = components?.url else {
            NSLog("Error delivering request URL ")
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
            
            }
//            (USUALLY decode data)
            
            guard let data = data else {
                NSLog("No data returned from search")
                completionClosure(nil)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let search = try decoder.decode(SearchResults.self, from: data)
                self.searchResults = search.results
                
            } catch {
                NSLog("Unable to decode data into search: \(error)")
                completionClosure(error)
            }
            completionClosure(nil)
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
