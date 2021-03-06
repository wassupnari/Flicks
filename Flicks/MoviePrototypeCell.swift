//
//  MoviePrototypeCellTableViewCell.swift
//  Flicks
//
//  Created by Nari Shin on 10/14/16.
//  Copyright © 2016 Nari Shin. All rights reserved.
//

import UIKit

class MoviePrototypeCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieOverview: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
