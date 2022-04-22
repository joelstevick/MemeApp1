//
//  Meme.swift
//  MemeMeApp1
//
//  Created by Joel Stevick on 4/21/22.
//

import UIKit

struct Meme {
    private var topTextField: String?
    private var bottomTextField: String?
    private var originalImage: UIImage?
    private var memedImage: UIImage?
    
    mutating func addTopTextField(_ topTextField: String)  {
        self.topTextField = topTextField
    }
    
    mutating func addBottomTextField(_ bottomTextField: String) {
        self.bottomTextField = bottomTextField
    }
    
    mutating func addOriginalImage(_ originalImage: UIImage) {
        self.originalImage = originalImage
    }
    
    var hasOriginalImage: Bool {
        return !(originalImage === nil)
    }
    mutating func reset() {
        topTextField = nil
        bottomTextField = nil
        originalImage = nil
    }
    func isValid() -> Bool {
        guard let _ = topTextField,
              let _ = bottomTextField,
              let _ = originalImage else {
            
            return false
        }
        
        return topTextField!.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
        && bottomTextField!.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
    }
    mutating func build(_ view: UIView, _ navigationController: UINavigationController?) -> UIImage {
        guard isValid() else {
            fatalError("All properties are required!")
        }
        
        // Hide toolbar and navbar
        if let navigationController = navigationController {
            navigationController.setToolbarHidden(true, animated: false)
            navigationController.setNavigationBarHidden(true, animated: false)
        }
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        if let navigationController = navigationController {
            navigationController.setToolbarHidden(false, animated: false)
            navigationController.setNavigationBarHidden(false, animated: false)
        }
        self.memedImage = memedImage
        
        return memedImage
    }
    
    func save() {
        UIImageWriteToSavedPhotosAlbum(memedImage!, nil, nil, nil)
    }
}
