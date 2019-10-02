//
//  SearchResultTableViewCell.swift
//  iTunes Search
//
//  Created by Lambda_School_Loaner_167 on 10/2/19.
//  Copyright © 2019 Dani. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var searchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let title = searchResult?.title,
            let artist = searchResult?.creator else { return }
        
        creatorLabel.text = artist
        titleLabel.text = title
        
                
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
