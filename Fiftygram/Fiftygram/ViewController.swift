//
//  ViewController.swift
//  Fiftygram
//
//  Created by Kat Berge on 11/21/20.
//  Copyright © 2020 Kat Berge. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let context = CIContext()
    // save original photo user inputs
    var original: UIImage?
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func choosePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            navigationController?.present(picker, animated: true, completion: nil)
        }
    }
    
    // functionality for Sepia button
    @IBAction func applySepia() {let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        display(filter: filter!)
    }
    
    // functionality for Noir button
    @IBAction func applyNoir() {
        let filter = CIFilter(name: "CIPhotoEffectNoir")
        display(filter: filter!)
    }
    
    // functionality for Vinatge button
    @IBAction func applyVinatge() {
        let filter = CIFilter(name: "CIPhotoEffectProcess")
        display(filter: filter!)
    }
    
    // helper function for filter functions' repeated code
    func display(filter: CIFilter) {
        // avoid crashing if there is no image
        if original == nil {
            return
        }
        
        filter.setValue(CIImage(image: original!), forKey: kCIInputImageKey)
        let output = filter.outputImage
        imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        navigationController?.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            original = image
        }
    }

}

