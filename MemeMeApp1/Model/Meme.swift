//
//  Meme.swift
//  MemeMeApp1
//
//  Created by Joel Stevick on 4/21/22.
//

import UIKit

class Meme {
    private var topTextField: String?
    private var bottomTextField: String?
    private var originalImage: UIImage?
    
    func addTopTextField(topTextField: String) -> Meme {
        
        self.topTextField = topTextField
        return self
    }
    
    func addBottomTextField(bottomTextField: String) -> Meme {
        
        self.bottomTextField = bottomTextField
        return self
    }
    
    func addOriginalImage(originalImage: UIImage) -> Meme {
        
        self.originalImage = originalImage
        return self
    }
    
    func isValid() -> Bool {
        guard let topTextField = topTextField,
              let bottomTextField = bottomTextField,
              let originalImage = originalImage else {
            
            return false
        }
        
        return true
    }
    func build(_ view: UIView, navigationController: UINavigationController) -> UIImage {
        guard isValid() else {
            fatalError("All properties are required!")
        }
        
        // Hide toolbar and navbar
        navigationController.setToolbarHidden(true, animated: false)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        navigationController.setToolbarHidden(false, animated: false)
        navigationController.setNavigationBarHidden(false, animated: false)
        
        return memedImage
    }
}
