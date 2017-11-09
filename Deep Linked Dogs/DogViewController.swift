//
//  DogViewController.swift
//  Deep Linked Dogs
//
//  Created by Clay Jones on 11/8/17.
//  Copyright © 2017 Branch Metrics. All rights reserved.
//

import UIKit
import Kingfisher

class DogViewController: UIViewController {
    
    var imageURL: String!
    var imageView: UIImageView!
    
    @objc func share() {
        //Implement sharing here
    }

    // DO NOT TOUCH BELOW
    //================================================================================

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let dogURL = URL(string: imageURL)
        imageView = UIImageView(frame: CGRect(x: 0, y: 66, width: view.frame.size.width, height: 400))
        imageView.kf.setImage(with: dogURL, completionHandler: { (image, error, cacheType, imageUrl) in
            let newImage = self.ResizeImage(image: image!, targetSize: self.imageView.frame.size)
            self.imageView.frame = CGRect(x: (self.view.frame.size.width - newImage.size.width)/2, y: 66, width: newImage.size.width, height: newImage.size.height)
            self.imageView.image = newImage
        })
        view.addSubview(imageView)
        
        let button = UIButton(type: .roundedRect)
        button.setTitle("Share", for: .normal)
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular ", size: 28)
        button.sizeToFit()
        button.addTarget(self, action: #selector(share), for: .touchUpInside)
        button.frame = CGRect(x: (view.frame.width - button.frame.width)/2, y: view.frame.size.height - 100, width: button.frame.size.width, height: button.frame.size.height)
        view.addSubview(button)
    }
    
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height:size.height * heightRatio)
        } else {
            newSize = CGSize(width:size.width * widthRatio,  height:size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0,y: 0,width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

}
