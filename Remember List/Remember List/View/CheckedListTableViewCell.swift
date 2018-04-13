//
//  CheckedListTableViewCell.swift
//  Remember List
//
//  Created by Thobio on 13/04/18.
//  Copyright © 2018 STapps. All rights reserved.
//

import UIKit

class CheckedListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
