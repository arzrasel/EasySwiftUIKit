//
//  ImageExtensions.swift
//  EasySwiftUIKit
//
//  Created by Rz Rasel on 2021-02-13
//

import Foundation
import UIKit

extension UIImage {
    public func resized(resizedTo: CGSize) -> UIImage {
        return crop(cropTo: resizedTo)
    }
    public func crop(cropTo: CGSize) -> UIImage {
        
        guard let cgimage = self.cgImage else { return self }
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        guard let newCgImage = contextImage.cgImage else { return self }
        
        let contextSize: CGSize = contextImage.size
        //Set to square
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        let cropAspect: CGFloat = cropTo.width / cropTo.height
        
        var cropWidth: CGFloat = cropTo.width
        var cropHeight: CGFloat = cropTo.height
        
        if cropTo.width > cropTo.height { //Landscape
            cropWidth = contextSize.width
            cropHeight = contextSize.width / cropAspect
            posY = (contextSize.height - cropHeight) / 2
        } else if cropTo.width < cropTo.height { //Portrait
            cropHeight = contextSize.height
            cropWidth = contextSize.height * cropAspect
            posX = (contextSize.width - cropWidth) / 2
        } else { //Square
            if contextSize.width >= contextSize.height { //Square on landscape (or square)
                cropHeight = contextSize.height
                cropWidth = contextSize.height * cropAspect
                posX = (contextSize.width - cropWidth) / 2
            }else{ //Square on portrait
                cropWidth = contextSize.width
                cropHeight = contextSize.width / cropAspect
                posY = (contextSize.height - cropHeight) / 2
            }
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cropWidth, height: cropHeight)
        
        // Create bitmap image from context using the rect
        guard let imageRef: CGImage = newCgImage.cropping(to: rect) else { return self}
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let cropped: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
        UIGraphicsBeginImageContextWithOptions(cropTo, false, self.scale)
        cropped.draw(in: CGRect(x: 0, y: 0, width: cropTo.width, height: cropTo.height))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resized ?? self
//        let size = CGSize(width: 300, height: 200)
//        let image = UIImage(named: "my_great_photo")?.crop(size)
    }
}
