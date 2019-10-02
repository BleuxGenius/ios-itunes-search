//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Lambda_School_Loaner_167 on 10/1/19.
//  Copyright © 2019 Dani. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
//    MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
//    MARK: -  Actions
    
    @IBAction func segmentedControlSwitched(_ sender: UISegmentedControl) {
       
        }
    
//    MARK: - Properties
    
//    create a constant
    let searchResultsController = SearchResultController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        set up the search bar in the controller
        searchBar.delegate = self

    }
//    MARK: - UISearchBarDelegate
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        setViewSelections()
            }
    
    func setViewSelections() {
        
        var resultType: ResultType!
        
        switch segmentedController.selectedSegmentIndex {
            
        case 0:
            resultType = .software
        case 1:
            resultType = .movie
        case 2:
            resultType = .musicTrack
        default:
            break
        }
        
        guard let searchBarText = searchBar.text else { return }
        
        searchResultsController.performSearch(with: searchBarText, resultType: resultType) { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as? SearchResultTableViewCell else {
            return UITableViewCell() }

        cell.searchResult = searchResultsController.searchResults[indexPath.row]
        return cell
    }


}
