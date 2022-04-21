//
//  ViewController.swift
//  MemeMeApp1
//
//  Created by Joel Stevick on 4/21/22.
//

import UIKit

class ViewController: UIViewController {
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.blue,
        NSAttributedString.Key.foregroundColor: UIColor.blue,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  0
    ]
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
        
    }


    @IBAction func albumPressed(_ sender: Any) {
    }
}

