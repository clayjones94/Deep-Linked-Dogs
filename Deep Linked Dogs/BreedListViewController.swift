//
//  BreedListViewController.swift
//  Deep Linked Dogs
//
//  Created by Clay Jones on 11/8/17.
//  Copyright © 2017 Branch Metrics. All rights reserved.
//

import UIKit

class BreedListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableview: UITableView!
    var breeds: [DogBreed]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview = UITableView(frame: self.view.frame, style: .plain)
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
        loadDogBreeds()
    }
    
    func loadDogBreeds() {
        DogDatabase.getAllBreeds { (breeds) in
            self.breeds = breeds
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (breeds != nil) {
            return (breeds?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableview.dequeueReusableCell(withIdentifier: "breed cell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "breed cell")
        }
        cell?.textLabel?.text = breeds![indexPath.row].name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let breed = breeds?[indexPath.row].name
        let vc = DogListViewController(breed: breed!)
        self.navigationController?.pushViewController(vc, animated: false)
    }

}
