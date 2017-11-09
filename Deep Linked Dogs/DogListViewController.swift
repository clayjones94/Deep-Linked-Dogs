//
//  DogListViewController.swift
//  Deep Linked Dogs
//
//  Created by Clay Jones on 11/8/17.
//  Copyright © 2017 Branch Metrics. All rights reserved.
//

import UIKit

class DogListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableview: UITableView!
    var dogs: [Dog]?
    var breed: String!
    
    init(breed: String) {
        self.breed = breed
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview = UITableView(frame: self.view.frame, style: .plain)
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
        loadDogBreeds()
    }
    
    func loadDogBreeds() {
        DogDatabase.getAllDogsForBreed(breed: self.breed) { (dogs) in
            self.dogs = dogs
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (dogs != nil) {
            return (dogs?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableview.dequeueReusableCell(withIdentifier: "breed cell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "breed cell")
        }
        cell?.textLabel?.text = dogs![indexPath.row].imageURL
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DogViewController()
        vc.imageURL = dogs?[indexPath.row].imageURL
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
