//
//  TableVC.swift
//  UITableViewCell05
//
//  Created by Nick Rodriguez on 14/08/2023.
//

import UIKit

class TableVC: UIViewController {
    
//    var requestStore: RequestStore!
    var urlStore:URLStore!
    var flickrStore:FlickrStore!

    
    let vwVCHeaderOrange = UIView()
    let vwVCHeaderOrangeTitle = UIView()
    let imgVwIconNoName = UIImageView()
    let lblHeaderTitle = UILabel()
    var stckVwTable=UIStackView()
    var tbl = UITableView()
    var arryPosts:[Post]!
    let stckVwAuxilary = UIStackView()
    let btnAuxilary = UIButton()
    let whlAuxilary = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tbl.delegate = self
        tbl.dataSource = self
        
        // Register a UITableViewCell
        tbl.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        tbl.rowHeight = UITableView.automaticDimension
        tbl.estimatedRowHeight = 500
        
        setup_vwVCHeaderOrange()
        setup_vwVCHeaderOrangeTitle()
        setup_stckVw()
        setupAuxilaryViews()
        stckVwTable.addArrangedSubview(tbl)

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
        
        lblHeaderTitle.text = "TableVC"
        lblHeaderTitle.font = UIFont(name: "Rockwell", size: 35)
        vwVCHeaderOrangeTitle.addSubview(lblHeaderTitle)
        lblHeaderTitle.translatesAutoresizingMaskIntoConstraints=false
        lblHeaderTitle.accessibilityIdentifier = "lblHeaderTitle"
        lblHeaderTitle.leadingAnchor.constraint(equalTo: imgVwIconNoName.trailingAnchor, constant: widthFromPct(percent: 2.5)).isActive=true
        lblHeaderTitle.centerYAnchor.constraint(equalTo: vwVCHeaderOrangeTitle.centerYAnchor).isActive=true
    }
    
    func setup_stckVw(){
        stckVwTable.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(stckVwTable)
        stckVwTable.topAnchor.constraint(equalTo: vwVCHeaderOrangeTitle.bottomAnchor).isActive=true
        stckVwTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
        stckVwTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive=true
        stckVwTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
        stckVwTable.axis = .vertical
        stckVwTable.spacing = 10
    }
    
    func setupAuxilaryViews() {
        let lblSpacer = UILabel()
        stckVwTable.addArrangedSubview(lblSpacer)
        lblSpacer.heightAnchor.constraint(equalToConstant: 10).isActive=true
        
        let lblTableCellRowInfo = UILabel()
        lblTableCellRowInfo.text = "Select UITableViewCell row:"
        lblTableCellRowInfo.numberOfLines=0
        stckVwTable.addArrangedSubview(lblTableCellRowInfo)
        
        // Configure UIButton
        btnAuxilary.setTitle("Auxilary Button", for: .normal)
        btnAuxilary.addTarget(self, action: #selector(btnAuxilaryTapped), for: .touchUpInside)
        btnAuxilary.layer.borderWidth = 2
        btnAuxilary.layer.borderColor = UIColor.blue.cgColor
        btnAuxilary.layer.cornerRadius = 10
        
        // Configure UIPickerView
        whlAuxilary.delegate = self
        whlAuxilary.dataSource = self
        whlAuxilary.heightAnchor.constraint(equalToConstant: 50).isActive=true
        
        // Add views to stckVwAuxilary
        stckVwAuxilary.addArrangedSubview(btnAuxilary)
        stckVwAuxilary.addArrangedSubview(whlAuxilary)
        stckVwAuxilary.distribution = .fillEqually
        
        // Add stckVwAuxilary to top of stckVwRincon
//        stckVwTable.insertArrangedSubview(stckVwAuxilary, at: 1)
        stckVwTable.addArrangedSubview(stckVwAuxilary)
    }

    @objc func btnAuxilaryTapped() {
        let selectedRowIndex = whlAuxilary.selectedRow(inComponent: 0)
        
        // Ensure the selected index is within the valid range
        if selectedRowIndex < arryPosts.count {
            let postToReload = arryPosts[selectedRowIndex]
            
            // Assuming you have a method or way to get IndexPath from post_id
            if let indexPath = getIndexPathForPostID(postToReload.postId) {
                let current_post_cell = tbl.cellForRow(at: indexPath) as! PostCell
                print("-PostCell SubViews-----------")
                listSubviews(of: current_post_cell.contentView)
                print("------------")

                
            }
            
        }
    }

    // Sample method to get IndexPath from post_id
    func getIndexPathForPostID(_ postID: String) -> IndexPath? {
        if let index = arryPosts.firstIndex(where: { $0.postId == postID }) {
            return IndexPath(row: index, section: 0)
        }
        return nil
    }
    


}

extension TableVC: UITableViewDelegate{
    
}

extension TableVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arryPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for:indexPath) as! PostCell
        
        let current_post = arryPosts[indexPath.row]
//        cell.requestStore = requestStore
        cell.flickrStore = flickrStore

        cell.indexPath = indexPath
        cell.configure(with: current_post)
        
        return cell
    }
    
    
}



extension TableVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arryPosts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arryPosts[row].postId
    }
}

