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
    
    func addTopTextField(_ topTextField: String)  {
        self.topTextField = topTextField
    }
    
    func addBottomTextField(_ bottomTextField: String) {
        self.bottomTextField = bottomTextField
    }
    
    func addOriginalImage(_ originalImage: UIImage) {
        self.originalImage = originalImage
    }
    
    func hasOriginalImage() -> Bool {
        return !(originalImage === nil)
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
