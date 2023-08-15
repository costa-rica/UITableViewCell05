//
//  PostCell.swift
//  UITableViewCell05
//
//  Created by Nick Rodriguez on 14/08/2023.
//

import UIKit

class PostCell: UITableViewCell{
    var requestStore:RequestStore!
    var post:Post!
    let screenWidth = UIScreen.main.bounds.width
    var indexPath:IndexPath!
    var stckVwPost=UIStackView()
    var lblUsername=UILabel()
    var dictImgVw:[String:UIImageView]?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with post:Post){
        self.post = post
        stckVwPost.translatesAutoresizingMaskIntoConstraints=false
        contentView.addSubview(stckVwPost)
        stckVwPost.topAnchor.constraint(equalTo: contentView.topAnchor).isActive=true
        stckVwPost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive=true
        stckVwPost.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive=true
        stckVwPost.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive=true

        stckVwPost.axis = .vertical
        stckVwPost.spacing = 10
        stckVwPost.backgroundColor = .brown
        stckVwPost.accessibilityIdentifier = "stckVwPost"
        
        lblUsername.text = post.username
        lblUsername.accessibilityIdentifier = "lblUsername"
        stckVwPost.addArrangedSubview(lblUsername)
        
        if post.image_files_array != nil{
            print("Download images")
            
        } else {
            print("No spinners")
            justShowSpinners()
        }
        print("VieDidLoad finished")
        listSubviews(of: contentView)
        print("stckVwPost.subviews")
        print(stckVwPost.arrangedSubviews)
    }
    

    func justShowSpinners(){
    dictImgVw=[String:UIImageView]()
        let imgName = "justSomeSpinner"
        dictImgVw![imgName] = createImgVwSpinner(imageAccessId: imgName)
        addImgVwToStckVwPost(imageAccessId: imgName, imgVw: dictImgVw![imgName]!)
    }

    
    func addImgVwToStckVwPost(imageAccessId:String, imgVw:UIImageView){
        imgVw.accessibilityIdentifier=imageAccessId
        stckVwPost.addArrangedSubview(imgVw)
    }

    func createImgVwSpinner(imageAccessId:String) -> UIImageView {
        
        // Create UIImageView with specified frame
        let imgVwSpinner = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 250))
        imgVwSpinner.backgroundColor = .black
        imgVwSpinner.accessibilityIdentifier = "imgVwSpinner"+imageAccessId

        // Create UIActivityIndicatorView
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.accessibilityIdentifier="spinner"+imageAccessId
        
        // Add UIActivityIndicatorView to UIImageView
        imgVwSpinner.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: imgVwSpinner.centerXAnchor).isActive=true
        spinner.centerYAnchor.constraint(equalTo: imgVwSpinner.centerYAnchor).isActive=true
        imgVwSpinner.heightAnchor.constraint(equalToConstant: 250).isActive=true
        
        return imgVwSpinner
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
}


//extension PostCell {
//
//
//    func adjustImageViewHeight(for image: UIImage, image_name:String) {
//        // If the constraint hasn't been initialized, find it
//        if imageViewHeightConstraint == nil {
////            imageViewHeightConstraint = imageView.constraints.first(where: { $0.firstAttribute == .height })
//            imageViewHeightConstraint = dictImgVw![image_name]!.constraints.first(where: { $0.firstAttribute == .height })
//        }
//
//        let aspectRatio = image.size.width / image.size.height
//        let newHeight = UIScreen.main.bounds.width / aspectRatio
//
//        print("post:\(post.post_id!) newHeight: \(newHeight)")
//        dictImgVw![image_name]!.accessibilityIdentifier = "resizedImageView"
//        dictImgVw![image_name]!.backgroundColor = .blue
//
//        imageViewHeightConstraint?.constant = newHeight
//
//    }
//
//
//    func resizeImageToFitScreenWidth(_ image: UIImage) -> UIImage? {
//        // Get screen width
//        let screenWidth = UIScreen.main.bounds.width
//
//        // Determine the aspect ratio of the image
//        let aspectRatio = image.size.width / image.size.height
//
//        // Calculate new height using the aspect ratio
//        let newHeight = screenWidth / aspectRatio
//
//        // Resize the image based on new dimensions
//        let newSize = CGSize(width: screenWidth, height: newHeight)
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
//        image.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
//
//        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return resizedImage
//    }
//}


