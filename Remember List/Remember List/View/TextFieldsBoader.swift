//
//  TextFieldsBoader.swift
//  Remember List
//
//  Created by Thobio on 11/04/18.
//  Copyright © 2018 STapps. All rights reserved.
//

import UIKit

class TextFieldsBoader: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
    }

}
