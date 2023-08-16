//
//  ViewController.swift
//  UITableViewCell05
//
//  Created by Nick Rodriguez on 14/08/2023.
//

import UIKit

class HomeVC: UIViewController {

    var urlStore:URLStore!
    var flickrStore:FlickrStore!
    
    let vwVCHeaderOrange = UIView()
    let vwVCHeaderOrangeTitle = UIView()
    let imgVwIconNoName = UIImageView()
    let lblHeaderTitle = UILabel()
    
    var stckVwHome = UIStackView()
    var lblDescription = UILabel()
    let btnToTable = UIButton()
    var post1:Post!
    var post2:Post!
    var arryPosts:[Post]!
    
    var btnCallFlickrInteresting=UIButton()
    var dictFlickrImages = [String:URL](){
        didSet{
            if dictFlickrImages.count > 0 {
                setup_stckVwImgList()
                setup_dummyPosts()
                removeView(withAccessibilityIdentifier: "lblWarning")
            }
        }
    }
    var stckVwImgList:UIStackView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        urlStore = URLStore()
        urlStore.apiBase = APIBase.flickr
        flickrStore = FlickrStore()
        flickrStore.requestStore = RequestStore()
        flickrStore.requestStore.urlStore=urlStore
        setup_vwVCHeaderOrange()
        setup_vwVCHeaderOrangeTitle()
        setup_stckVwHome()
        setup_flickr()
        setup_appDescription()
        setup_btnGoToTable()
    }
    
    func setup_dummyPosts(){
        arryPosts = [Post]()
        for (index, img) in dictFlickrImages.enumerated(){
            let post = Post()
            post.postId = String(index)
            post.username = "costa-rica" + post.postId
            post.imageName = img.key
            post.imageURL = img.value
            arryPosts.append(post)
        }
    }
    
    func setup_vwVCHeaderOrange(){
        view.addSubview(vwVCHeaderOrange)
        vwVCHeaderOrange.backgroundColor = environmentColor(urlStore: urlStore)
        vwVCHeaderOrange.translatesAutoresizingMaskIntoConstraints = false
        vwVCHeaderOrange.accessibilityIdentifier = "vwVCHeaderOrange"
        vwVCHeaderOrange.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        vwVCHeaderOrange.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        vwVCHeaderOrange.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
        vwVCHeaderOrange.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
    }
    func setup_vwVCHeaderOrangeTitle(){
        view.addSubview(vwVCHeaderOrangeTitle)
        vwVCHeaderOrangeTitle.backgroundColor = UIColor.brown
        vwVCHeaderOrangeTitle.translatesAutoresizingMaskIntoConstraints = false
        vwVCHeaderOrangeTitle.accessibilityIdentifier = "vwVCHeaderOrangeTitle"
        vwVCHeaderOrangeTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        vwVCHeaderOrangeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
        vwVCHeaderOrangeTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
        
        if let unwrapped_image = UIImage(named: "android-chrome-192x192") {
            imgVwIconNoName.image = unwrapped_image.scaleImage(toSize: CGSize(width: 20, height: 20))
            vwVCHeaderOrangeTitle.heightAnchor.constraint(equalToConstant: imgVwIconNoName.image!.size.height + 10).isActive=true
        }
        imgVwIconNoName.translatesAutoresizingMaskIntoConstraints = false
        imgVwIconNoName.accessibilityIdentifier = "imgVwIconNoName"
        vwVCHeaderOrangeTitle.addSubview(imgVwIconNoName)
        imgVwIconNoName.topAnchor.constraint(equalTo: vwVCHeaderOrangeTitle.topAnchor).isActive=true
        imgVwIconNoName.leadingAnchor.constraint(equalTo: vwVCHeaderOrangeTitle.centerXAnchor, constant: widthFromPct(percent: -35) ).isActive = true
        
        lblHeaderTitle.text = "HomeVC"
        lblHeaderTitle.font = UIFont(name: "Rockwell", size: 35)
        vwVCHeaderOrangeTitle.addSubview(lblHeaderTitle)
        lblHeaderTitle.translatesAutoresizingMaskIntoConstraints=false
        lblHeaderTitle.accessibilityIdentifier = "lblHeaderTitle"
        lblHeaderTitle.leadingAnchor.constraint(equalTo: imgVwIconNoName.trailingAnchor, constant: widthFromPct(percent: 2.5)).isActive=true
        lblHeaderTitle.centerYAnchor.constraint(equalTo: vwVCHeaderOrangeTitle.centerYAnchor).isActive=true
    }
    func setup_stckVwHome(){
        stckVwHome.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(stckVwHome)
        stckVwHome.topAnchor.constraint(equalTo: vwVCHeaderOrangeTitle.bottomAnchor, constant: 100).isActive=true
        stckVwHome.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
        stckVwHome.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
        stckVwHome.axis = .vertical
        stckVwHome.accessibilityIdentifier="stckVwHome"
    }
    func setup_appDescription(){
        lblDescription.text = "This application is designed to test out how a UITableViewCell can be dynamic."
        lblDescription.numberOfLines=0
        stckVwHome.insertArrangedSubview(lblDescription, at: 0)
    }
    func setup_flickr(){
        btnCallFlickrInteresting.setTitle("Call For Flickr Images", for: .normal)
        stckVwHome.addArrangedSubview(btnCallFlickrInteresting)
        btnCallFlickrInteresting.layer.borderWidth = 2
        btnCallFlickrInteresting.layer.borderColor = UIColor.blue.cgColor
        btnCallFlickrInteresting.layer.cornerRadius = 10
        btnCallFlickrInteresting.addTarget(self, action: #selector(touchDownBtnCallFlickrInteresting), for: .touchDown)
        btnCallFlickrInteresting.addTarget(self, action: #selector(touchUpInsideBtnCallFlickrInteresting), for: .touchUpInside)
        
    }
    @objc func touchDownBtnCallFlickrInteresting(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseOut], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: nil)
    }
    @objc func touchUpInsideBtnCallFlickrInteresting(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
        flickrStore.fetchInterestingPhotosEndpoint { resultResponse in
            
            switch resultResponse{
            case let .success(flickrResponse):
                var dictTemp = [String:URL]()
                for photoDets in flickrResponse.photosInfo.photos{
                    if let unwp_url = photoDets.url_z{
                        dictTemp[photoDets.title] = unwp_url
                    }
                }
                self.dictFlickrImages = dictTemp

            case let .failure(error):
                print("error: \(error)")
            }
        }
    }
    func setup_stckVwImgList(){
        stckVwImgList=UIStackView()
        stckVwImgList?.axis = .vertical
        
        for flickrImg in dictFlickrImages{
            let lbl = UILabel()
            lbl.text = flickrImg.key
            stckVwImgList?.addArrangedSubview(lbl)
        }
//        for (index, post) in arryPosts.enumerated(){
//
//            post.imageName = Array(dictFlickrImages.keys)[index]
//            post.imageURL = dictFlickrImages[Array(dictFlickrImages.keys)[index]]
//
//        }
        stckVwHome.addArrangedSubview(stckVwImgList!)
    }
    func setup_btnGoToTable(){
        btnToTable.setTitle("Go To Table", for: .normal)
        btnToTable.translatesAutoresizingMaskIntoConstraints=false
        stckVwHome.addArrangedSubview(btnToTable)
        btnToTable.addTarget(self, action: #selector(touchDownBtnToTable), for: .touchDown)
        btnToTable.addTarget(self, action: #selector(touchUpInsideBtnToTable), for: .touchUpInside)
    }
    
    @objc func touchDownBtnToTable(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseOut], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: nil)
    }

    @objc func touchUpInsideBtnToTable(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
        if arryPosts != nil{
            if sender === btnToTable {

//                print("btnToTable")
                performSegue(withIdentifier: "goToTableVC", sender: self)
            }
        }
        else{
            let lblWarning = UILabel()
            lblWarning.text = "No data for UITableView, click call for Flickr Images"
            lblWarning.textColor = .red
            lblWarning.accessibilityIdentifier="lblWarning"
            stckVwHome.addArrangedSubview(lblWarning)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTableVC"{
            let tableVC = segue.destination as! TableVC
            tableVC.arryPosts = arryPosts
            tableVC.flickrStore = flickrStore
            tableVC.urlStore = urlStore
        }
    }

}

extension UIViewController {
    func removeView(withAccessibilityIdentifier identifier: String) {
        for subview in view.subviews {
            if subview.accessibilityIdentifier != identifier {
                if subview.subviews.count > 0 {
                    for subsubview in subview.subviews {
                        if subsubview.accessibilityIdentifier == identifier {
                            subsubview.removeFromSuperview()
                            break
                        }
                    }
                }
            }
            if subview.accessibilityIdentifier == identifier {
                subview.removeFromSuperview()
                break
            }
        }
    }
}

