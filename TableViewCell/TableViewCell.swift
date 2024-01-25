//
//  TableViewCell.swift
//  NewYorkTimesApi
//
//  Created by MacBook Pro on 13/12/2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsName: UILabel!
    

    @IBOutlet weak var newsTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
