//
//  Utilities.swift
//  UITableViewCell05
//
//  Created by Nick Rodriguez on 14/08/2023.
//

import UIKit

func environmentColor(urlStore:URLStore) -> UIColor{
    if urlStore.apiBase == .flickr{
        return UIColor(named: "orangePrimary") ?? UIColor.orange
    } else if urlStore.apiBase == .local{
        return UIColor(hex: "#8ea202")
    }
    return UIColor.cyan
}

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hex.hasPrefix("#") {
            hex.remove(at: hex.startIndex)
        }
        
        var rgb: UInt64 = 0
        
        Scanner(string: hex).scanHexInt64(&rgb)
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UIImage {
    func scaleImage(toSize newSize: CGSize) -> UIImage? {
        var newImage: UIImage?
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        if let context = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage {
            context.interpolationQuality = .high
            let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)
            context.concatenate(flipVertical)
            context.draw(cgImage, in: newRect)
            if let img = context.makeImage() {
                newImage = UIImage(cgImage: img)
            }
            UIGraphicsEndImageContext()
        }
        return newImage
    }
}

func widthFromPct(percent:Float) -> CGFloat {
    let screenWidth = UIScreen.main.bounds.width
    let width = screenWidth * CGFloat(percent/100)
    return width
}

func heightFromPct(percent:Float) -> CGFloat {
    let screenHeight = UIScreen.main.bounds.height
    let height = screenHeight * CGFloat(percent/100)
    return height
}

func listSubviews(of view: UIView, indent: Int = 0) {
    let indentation = String(repeating: " ", count: indent)
    
    if let identifier = view.accessibilityIdentifier {
        print("\(indentation)\(view) - \(identifier)")
    } else {
        print("\(indentation)\(view)")
    }
    
    for subview in view.subviews {
        listSubviews(of: subview, indent: indent + 2)
    }
}


func resizeImageToFitScreenWidth(_ image: UIImage) -> UIImage? {
    // Get screen width
    let screenWidth = UIScreen.main.bounds.width
    
    // Determine the aspect ratio of the image
    let aspectRatio = image.size.width / image.size.height
    
    // Calculate new height using the aspect ratio
    let newHeight = screenWidth / aspectRatio
    
    // Resize the image based on new dimensions
    let newSize = CGSize(width: screenWidth, height: newHeight)
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
    image.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
    
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return resizedImage
}


