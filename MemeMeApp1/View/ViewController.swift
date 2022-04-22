//
//  ViewController.swift
//  MemeMeApp1
//
//  Created by Joel Stevick on 4/21/22.
//

import UIKit

class ViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate,  UITextFieldDelegate {
    let pickerController = UIImagePickerController()
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.white,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  0
    ]
    var meme = Meme()
    
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    
    // MARK: - view lifecycle methods
    override func viewDidAppear(_ animated: Bool) {
        topText.delegate = self
        bottomText.delegate = self
        shareBtn.isEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
        pickerController.delegate = self
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeToKeyboardNotifications()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - TextField Delegates
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateModel()
    }

    func updateModel() {
        if let text = topText.text {
            meme.addTopTextField(text)
        }
        if let text = bottomText.text {
            meme.addBottomTextField(text)
        }
        
        shareBtn.isEnabled = meme.isValid()
        

    }
    // MARK: - Actions
    @IBAction func albumPressed(_ sender: Any) {
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    // MARK: - Keyboard adjustments
    @objc func keyboardWillShow(_ notification: Notification) {
        view.frame.origin.y = -1 * getKeyboardHeight(notification)
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications () {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil )
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil )
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}

