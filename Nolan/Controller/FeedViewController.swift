//
//  FeedViewController.swift
//  Nolan
//
//  Created by Eduarda Mello on 29/10/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var scanButoon: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let allPoses = Singleton.shared.sessions.flatMap( {$0.pose} )
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
//        collectionView.contentInset.top = max((collectionView.frame.height - collectionView.contentSize.height) / 2, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200  , height: 200)
    }
    
    //MARK: CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return favoritePoses.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritePoses", for: indexPath) as! FavoritePosesCollectionViewCell
        
        cell.topLabel.text = favoritePoses[indexPath.row].name
        cell.levelLabel.text = favoritePoses[indexPath.row].difficulty
        
        return cell
    }

    
    func dismissKeyboard() {
            view.endEditing(true)
        }

    
    
    //MARK: TableView
    //TODO: popular com um singleton de poses
    var indice = 0
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Singleton.shared.sessions[indice].pose.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "poses", for: indexPath) as! PosesTableViewCell
        cell.poseImage.image  = UIImage(named:"Image1")
        
        
        cell.poseLabel.text = allPoses[indexPath.row].name
        cell.levelLabel.text = allPoses[indexPath.row].difficulty
        if(allPoses[indexPath.row].favorite){
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
 
    
}
