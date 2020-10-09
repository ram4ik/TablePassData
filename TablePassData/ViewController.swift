//
//  ViewController.swift
//  TablePassData
//
//  Created by ramil on 09.10.2020.
//

import UIKit

class ViewController: UIViewController {
    
    var refreshControl = UIRefreshControl()
    
    private var bankLocations: [BankLocations] = []
    private var regions = [String]()
    private var selectedRegion = BankRegions.estonia
    private var regionUrl = ""
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        self.getData()
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
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
            self.tableView.reloadData()
        }
        
        nm.retriveDataFromJsonFile(selectedRegion.rawValue) { (bankLocations, regions) in
            self.regions = regions
            self.bankLocations = bankLocations
            self.tableView.reloadData()
        }
        
        refreshControl.endRefreshing()
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let category = regions[indexPath.row]
        
        let vc = ListViewController(items: filterRegions(bankLocation: bankLocations, by: category))
        vc.title = category
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func filterRegions(bankLocation: [BankLocations], by region: String) -> [BankLocations] {
            return bankLocation.filter { $0.r == region }
        }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = selectedRegion.rawValue.capitalized
        label.backgroundColor = UIColor.lightGray
        return label
    }
}

extension ViewController: UITableViewDataSource { 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = regions[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

