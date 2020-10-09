//
//  ViewController.swift
//  TablePassData
//
//  Created by ramil on 09.10.2020.
//

import UIKit

struct Category {
    let title: String
    let items: [String]
}

class ViewController: UIViewController {
    
    private var bankLocations: [BankLocations] = []
    private var regions = [String]()
    private var selectedRegion = BankRegions.estonia
    private var regionUrl = ""
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let data: [Category] = [
        Category(title: "Fruits", items: ["Apple", "Banana", "Orange", "Grape"]),
        Category(title: "Car Models", items: ["BMW", "Honda", "Ferrari", "Citroen"]),
        Category(title: "Apple Devices", items: ["iPad", "iPhone", "iMac", "MacBook"]),
        Category(title: "Weather", items: ["Sunny", "Banana", "Orange", "Grape"]),
        Category(title: "Cities", items: ["Tallinn", "Parnu", "Tartu", "Narva"])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        self.getData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func getRegionUrl() {
            switch selectedRegion {
            case .estonia:
                regionUrl = "https://www.swedbank.ee/finder.json"
            case .latvia:
                regionUrl = "https://ib.swedbank.lv/finder.json"
            case .lithuenia:
                regionUrl = "https://ib.swedbank.lt/finder.json"
            }
        }
    
    func getData() {
            let nm = NetworkManger()
            
            getRegionUrl()
            
            nm.getPosts(regionName: selectedRegion, regionUrl: regionUrl) { (bankLocations, regions) in
                self.regions = regions
                self.bankLocations = bankLocations
            }
            
            nm.retriveDataFromJsonFile(selectedRegion.rawValue) { (bankLocations, regions) in
                self.regions = regions
                self.bankLocations = bankLocations
                
            }
        }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let category = data[indexPath.row]
        
        let vc = ListViewController(items: category.items)
        vc.title = category.title
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource { 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].title
        return cell
    }
}

