//
//  PostCell.swift
//  UITableViewCell05
//
//  Created by Nick Rodriguez on 14/08/2023.
//

import UIKit

class PostCell: UITableViewCell{
    var flickrStore:FlickrStore!
    var post:Post!
    let screenWidth = UIScreen.main.bounds.width
    var indexPath:IndexPath!
    var stckVwPost=UIStackView()
    var lblUsername=UILabel()
    var dictImgVw:[String:UIImageView]?
    var imgVwSpinnerHeightConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stckVwPost.removeFromSuperview()
        lblUsername.removeFromSuperview()
        if post.imageURL != nil {
            dictImgVw?[post.imageName!]?.removeFromSuperview()
        }
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
        stckVwPost.accessibilityIdentifier = "stckVwPost"
        
        lblUsername.text = post.username
        lblUsername.accessibilityIdentifier = "lblUsername"
        stckVwPost.addArrangedSubview(lblUsername)
        
        if let _ =  post.imageURL{
            print("Download images")
            dictImgVw=[String:UIImageView]()
            addImage()
        }
    }
    

    func justShowSpinners(imgName:String){
        dictImgVw![imgName] = createImgVwSpinner(imageAccessId: imgName)
        addImgVwToStckVwPost(imageAccessId: imgName, imgVw: dictImgVw![imgName]!)
    }

    
    func addImgVwToStckVwPost(imageAccessId:String, imgVw:UIImageView){
        imgVw.accessibilityIdentifier=imageAccessId
        stckVwPost.addArrangedSubview(imgVw)
    }

    func createImgVwSpinner(imageAccessId:String) -> UIImageView {
        
        // Create UIImageView with specified frame
        let imgVwSpinner = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 450))
        imgVwSpinner.backgroundColor = .black
        imgVwSpinner.accessibilityIdentifier = "imgVwSpinner"+imageAccessId

        // Create UIActivityIndicatorView
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.accessibilityIdentifier="spinner"+imageAccessId
        
        // Add UIActivityIndicatorView to UIImageView
        imgVwSpinner.addSubview(spinner)
        
        // Set constraints
        spinner.centerXAnchor.constraint(equalTo: imgVwSpinner.centerXAnchor).isActive=true
        spinner.centerYAnchor.constraint(equalTo: imgVwSpinner.centerYAnchor).isActive=true
        imgVwSpinnerHeightConstraint = imgVwSpinner.heightAnchor.constraint(equalToConstant: 450)
        imgVwSpinnerHeightConstraint?.priority = UILayoutPriority(rawValue: 999) // Just below the default high priority
        imgVwSpinnerHeightConstraint?.isActive = true

        return imgVwSpinner
    }
    
    
    func addImage(){
        justShowSpinners(imgName: post.imageName!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
            self.flickrStore.fetchImageFromWeb(imgURL: self.post.imageURL!) { resultResponse in
                switch resultResponse{
                case let .success(uiimage):
                    self.dictImgVw![self.post.imageName!]?.removeFromSuperview()
                    self.imgVwSpinnerHeightConstraint?.isActive = false
                    let resizedUIImage = resizeImageToFitScreenWidth(uiimage)
                    self.dictImgVw![self.post.imageName!] = UIImageView(image: resizedUIImage)
                    self.stckVwPost.addArrangedSubview(self.dictImgVw![self.post.imageName!]!)
                    guard let tbl = self.superview as? UITableView else { return }
                    tbl.beginUpdates()
                    tbl.endUpdates()
                case let .failure(error):
                    print("Error adding image: \(error)")
                }
            }
        }
    }
}


