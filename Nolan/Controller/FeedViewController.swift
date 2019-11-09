//
//  FeedViewController.swift
//  Nolan
//
//  Created by Eduarda Mello on 29/10/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    @IBOutlet var feedView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var scanButoon: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelAllPoses: UILabel!
    
    var selectedPose: Pose?
    var collectionHeightConstant = CGFloat()
    let allPoses = Singleton.shared.sessions.flatMap( {$0.pose} )
    var filteredPoses = [Pose]()
    let favoritePoses = Singleton.shared.sessions.flatMap( {$0.pose} ).filter({$0.favorite})
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = 85.0
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchBar.delegate = self
        
        filteredPoses = allPoses
        
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionHeightConstant = collectionHeight.constant
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: Move Up

    @objc func keyboardWillChange(notification: NSNotification) {
        if let _: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            collectionHeight.constant = 0
        }
    }
    
    @objc func keyboardWillHide() {
        
        collectionHeight.constant = collectionHeightConstant
    }
    
     //MARK: SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPoses = allPoses.filter({$0.name.uppercased().contains(searchText.uppercased())})
        tableView.reloadData()
        
        if searchText  == "" {
            filteredPoses = allPoses
            tableView.reloadData()
        }
    }
    
    //MARK: CollectionView
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200  , height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return favoritePoses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritePoses", for: indexPath) as! FavoritePosesCollectionViewCell
        
        cell.topLabel.text = favoritePoses[indexPath.row].name
        cell.levelLabel.text = favoritePoses[indexPath.row].difficulty
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPose = favoritePoses[indexPath.row]
        self.performSegue(withIdentifier: "showFavoritePose", sender: selectedPose)
    }

    
    //MARK: TableView
    var indice = 0
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredPoses.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "poses", for: indexPath) as! PosesTableViewCell
        cell.poseImage.image  = UIImage(named:"image1")
        
        
        cell.poseLabel.text = filteredPoses[indexPath.row].name
        
        if(filteredPoses[indexPath.row].favorite){
            let config = UIImage.SymbolConfiguration(textStyle: .body)
            let favoriteImage = UIImage(systemName: "bookmark.fill", withConfiguration: config)
            cell.buttonFavorite.setImage(favoriteImage, for: .normal)
        } else {
            let config = UIImage.SymbolConfiguration(textStyle: .body)
            let favoriteImage = UIImage(systemName: "bookmark", withConfiguration: config)
            cell.buttonFavorite.setImage(favoriteImage, for: .normal)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPose = allPoses[indexPath.row]
        self.performSegue(withIdentifier: "showFavoritePose", sender: selectedPose)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFavoritePose" {
            if let destination = segue.destination as? PoseDescriptionViewController {
                destination.pose = selectedPose
            }
        }
    }

}

// MARK: Hide Keyboard

extension FeedViewController {

   func hideKeyboardWhenTappedAround() {
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FeedViewController.dismissKeyboard(_:)))
       tap.cancelsTouchesInView = false
       view.addGestureRecognizer(tap)
   }

   @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
       view.endEditing(true)

       if let nav = self.navigationController {
           nav.view.endEditing(true)
       }
   }
}
