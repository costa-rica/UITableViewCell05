//
//  ViewController.swift
//  UITableViewCell05
//
//  Created by Nick Rodriguez on 14/08/2023.
//

import UIKit

class HomeVC: UIViewController {
    var requestStore: RequestStore!
    var urlStore:URLStore!
    
    let vwVCHeaderOrange = UIView()
    let vwVCHeaderOrangeTitle = UIView()
    let imgVwIconNoName = UIImageView()
    let lblHeaderTitle = UILabel()
    let btnToTable = UIButton()
    
    var stckVwHome = UIStackView()
    
    var post1:Post!
    var post2:Post!
    var arryPosts:[Post]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        requestStore = RequestStore()
        urlStore = URLStore()
        urlStore.apiBase = APIBase.flickr
        
        setup_vwVCHeaderOrange()
        setup_vwVCHeaderOrangeTitle()
        setup_moreButtons()
        setup_dummyPosts()
    }
    
    func setup_dummyPosts(){
        post1 = Post()
        post1.post_id = "1"
        post1.username = "costa-rica"
        post2 = Post()
        post2.post_id = "2"
        post2.username = "costa-rica"
        post2.image_files_array=["img1"]
        arryPosts = [post1]
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
    
    func setup_moreButtons(){
        stckVwHome.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(stckVwHome)
        stckVwHome.topAnchor.constraint(equalTo: vwVCHeaderOrangeTitle.bottomAnchor, constant: 100).isActive=true
        stckVwHome.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
        stckVwHome.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
        stckVwHome.axis = .vertical
        
        btnToTable.setTitle("Go To Table", for: .normal)
        btnToTable.translatesAutoresizingMaskIntoConstraints=false
        stckVwHome.addArrangedSubview(btnToTable)
        btnToTable.addTarget(self, action: #selector(touchDownBtnToTable), for: .touchDown)
        btnToTable.addTarget(self, action: #selector(touchUpInsideBtnToTable), for: .touchUpInside)
        
//        btnGetPost.setTitle("Get Posts", for: .normal)
//        btnGetPost.translatesAutoresizingMaskIntoConstraints=false
//        stckVwLogin.addArrangedSubview(btnGetPost)
//        btnGetPost.addTarget(self, action: #selector(touchDownBtnGetPost), for: .touchDown)
//        btnGetPost.addTarget(self, action: #selector(touchUpInsideBtnGetPost), for: .touchUpInside)
        
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
        if sender === btnToTable {
            print("btnToTable")
            performSegue(withIdentifier: "goToTableVC", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTableVC"{
            let tableVC = segue.destination as! TableVC
            tableVC.arryPosts = arryPosts
        }
    }

}

