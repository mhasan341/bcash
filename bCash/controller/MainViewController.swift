//
//  MainViewController.swift
//  bCash
//
//  Created by Mahmud on 2021-09-13.
//

import UIKit

class MainViewController: UITableViewController {

    // we'll keep our data here
    var items = [GitUsers]()
    // Git API uses a Link header that contains url and a "since" value to load next batch of users.
    // for this quick project, we can randomly increase this value and get more users
    var sinceValue: Int = 0
    
    // this bool keeps track
    var isLoadingUsers = false

    var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // set the height of row
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = 80
        
        // let's start loading the first batch of users
        loadGitUsers()
    }

    // we'll need the nav bar here
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK:- LOAD GIT USERS
    
    func loadGitUsers(){
        // to indicate we are now in a network call
        isLoadingUsers = true
        showIndicator()
        
        // call to our manager
        NetworkManager.shared.getUsers(upto: getSinceValue()) { [weak self] result in
            guard let self = self else { return }
            
            // either success or failure
            switch result {
                case .success(let followers):
                    // append all items to existing list
                    self.items.append(contentsOf: followers)
                    // all UI updates must be done in main queue
                    DispatchQueue.main.async {
                        // reload the tableview
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    // when failure, show a banner for now
                    DispatchQueue.main.async {
                        // reload the tableview
                        self.showErrorBanner(withMessage: error.rawValue)
                    }
                    
            }
            // network call is done, success or failure, remove progress/loading flags now
            self.isLoadingUsers = false
            DispatchQueue.main.async {
                // hide the indicator
                self.hideIndicator()
            }
            
        }
    }
    
    
    // Git API uses a Link header that contains url and a "since" value to load next batch of users.
    // for this quick project, we can randomly increase this value and get more users
    func getSinceValue()-> Int {
        let random = Int.random(in: 50...100)
        sinceValue += random
        return sinceValue
    }
    
    // this method also borrowed from one of my recent project
    // to show the loading
    func showIndicator() {
        // to show a indicator while on call
        indicator = UIActivityIndicatorView(style: .large)
        indicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        indicator.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.maxY - 20)
        view.addSubview(indicator)
        indicator.bringSubviewToFront(view)
        
        // start
        indicator.startAnimating()
    }
    
    
    func hideIndicator() {
        indicator.removeFromSuperview()
        indicator.stopAnimating()
    }
    
    // MARK:- DELEGATES
    
    // how many rows to display
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // get a cell for each row
    // we'll reuse the cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeue a system cell
        let cell = GitTableViewCell(style: .value1, reuseIdentifier: "Cell")
        
        let item = items[indexPath.row]
        
        // show the username
        cell.textLabel?.text = item.login
        
        // load a default image
        cell.imageView?.image = UIImage(named: "logo")
        
        // download the image
        NetworkManager.shared.downloadImage(from: item.avatarUrl) { image in
            guard image != nil else{
                print("Error while downloading image")
                return
            }
            // load the image on main thread
            DispatchQueue.main.async {
                cell.imageView?.image = image
                cell.setNeedsLayout()
            }
        }
        
        return cell
    }
    
    
    
    // Load again when user at the bottom
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // find if user is at the bottom
        
        // The content height of scroll view
        let contentHeight = scrollView.contentSize.height
        // frame size
        let frameHeight = scrollView.frame.size.height
        // The point at which the origin of the content view is offset from the origin of the scroll view.
        let contentYoffset = scrollView.contentOffset.y
        
        
        if contentYoffset > contentHeight - frameHeight {
            // load more user
            // check if we are already loading, this prevents brushfire of network calls
            guard !isLoadingUsers else {
                return
            }
            
            // load more as weren't loading now
            loadGitUsers()
        }
        
    }
    
}
