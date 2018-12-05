//
//  ViewController.swift
//  StrechableHeaderWithTransparentNavBar
//
//  Created by Akash kahalkar on 05/12/18.
//  Copyright © 2018 Akashka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var strechableTableView: UITableView!
    let imageView = UIImageView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //main property for this to work is under top bar in viewcontroller setting should be selected
        setupHeaderView(with: UIImage(named: "mustang") ?? UIImage())
    }

    /// creates header in tableview with give image of respective height, if no height is provided th
    /// it defaults to 300
    ///
    /// - Parameters:
    ///   - image: image to set as header image
    ///   - height: height for header
    private func setupHeaderView(with image: UIImage, height: CGFloat = 300.0) {
        
        //keeping space for image to add
        strechableTableView.contentInset = UIEdgeInsets(top: height, left: 0.0, bottom: 0.0, right: 0.0)
        strechableTableView.tableFooterView = UIView()
        //used 55 offset as it was creatiing space
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height + 55)
        imageView.backgroundColor = UIColor.white
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "DemoText"
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let ifHeaderReachesTop: Bool = scrollView.contentOffset.y > -100
        
        setTransparentBar(flag: !ifHeaderReachesTop)
        imageView.isHidden = ifHeaderReachesTop
        let y = 300 - (scrollView.contentOffset.y + 300)
        let height = min(max(y, 40), UIScreen.main.bounds.size.height)
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height + 55)
        
    }
    
    func setTransparentBar(flag: Bool) {

        let navbarImage: UIImage? = flag ? UIImage() : nil
        let navBarColor = flag ? UIColor.clear : UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(navbarImage, for: .default)
        self.navigationController?.navigationBar.shadowImage = navbarImage
        self.navigationController?.navigationBar.isTranslucent = flag
        self.navigationController?.view.backgroundColor = navBarColor
        self.navigationController?.navigationBar.tintColor = .black
    }
}


