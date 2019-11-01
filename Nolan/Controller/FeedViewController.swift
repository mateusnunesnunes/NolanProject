//
//  FeedViewController.swift
//  Nolan
//
//  Created by Eduarda Mello on 29/10/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var scanButoon: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let allPoses = Singleton.shared.sessions.flatMap( {$0.pose} )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = 85.0
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    //MARK: CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Singleton.shared.sessions[indice].pose.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritePoses", for: indexPath) as! FavoritePosesCollectionViewCell
        
        return cell
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
    
}
