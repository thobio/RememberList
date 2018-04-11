//
//  DateListTableViewCell.swift
//  Remember List
//
//  Created by Thobio on 09/04/18.
//  Copyright © 2018 STapps. All rights reserved.
//

import UIKit

class DateListTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundViewCell: UIView!
    @IBOutlet weak var dateTillAlert: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundViewCell.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
