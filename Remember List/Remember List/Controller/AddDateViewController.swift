//
//  AddDateViewController.swift
//  Remember List
//
//  Created by Thobio on 11/04/18.
//  Copyright © 2018 STapps. All rights reserved.
//

import UIKit

class AddDateViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    
    //MARK: - Variable Declaration
    
    @IBOutlet weak var titleText: UITextField!
    var dates = NSDate()
    @IBOutlet weak var commentTextFields: UITextView!
    
    //MARK: - Main Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleText.delegate = self
        self.commentTextFields.delegate = self
    }
    
    //MARK: - TextField Delegetes
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Item Button Action
    
    @IBAction func saveToAddList(_ sender: Any) {
        if ((titleText.text?.isEmpty)! && (commentTextFields.text != nil)){
            let alert = UIAlertController(title: "Error", message: "Please fill your data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { (alertAction) in
            }))
            self.present(alert, animated: true, completion:nil)
        }else{
            let details = Detials(context: context!)
            details.dates = dates
            details.names = titleText.text
            details.comments = commentTextFields.text
            details.isAdded = false
            appDelegate?.saveContext()
            let alert = UIAlertController(title: "Saved", message: "Your list have been added.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { (alertAction) in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion:nil)
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
