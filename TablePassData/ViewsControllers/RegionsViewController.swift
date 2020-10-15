//
//  ViewController.swift
//  TablePassData
//
//  Created by ramil on 09.10.2020.
//

import UIKit

class RegionsViewController: UIViewController {
    
    var refreshControl = UIRefreshControl()
    
    private var bankLocationsEstonia: [BankLocations] = []
    private var regionsEstonia = [String]()
    private var bankLocationsLatvia: [BankLocations] = []
    private var regionsLatvia = [String]()
    private var bankLocationsLithuania: [BankLocations] = []
    private var regionsLithuania = [String]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        refreshAllRegions()
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        let _ = Timer.scheduledTimer(timeInterval: 3600, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        refreshAllRegions()
    }
    
    @objc func update() {
        refreshAllRegions()
    }
    
    func refreshAllRegions() {
        self.getDataForEstonia()
        self.getDataForLatvia()
        self.getDataForLithuania()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func getDataForEstonia() {
        let nm = NetworkManger()
        nm.getPosts(country: .estonia, url: Country.estonia.url) { (bankLocations, regions) in
            self.regionsEstonia = regions
            self.bankLocationsEstonia = bankLocations
            self.tableView.reloadData()
        }
        nm.retriveDataFromJsonFile(Country.estonia.name) { (bankLocations, regions) in
            self.regionsEstonia = regions
            self.bankLocationsEstonia = bankLocations
            self.tableView.reloadData()
        }
        refreshControl.endRefreshing()
    }
    
    func getDataForLatvia() {
        let nm = NetworkManger()
        nm.getPosts(country: .latvia, url: Country.latvia.url) { (bankLocations, regions) in
            self.regionsLatvia = regions
            self.bankLocationsLatvia = bankLocations
            self.tableView.reloadData()
        }
        nm.retriveDataFromJsonFile(Country.latvia.name) { (bankLocations, regions) in
            self.regionsLatvia = regions
            self.bankLocationsLatvia = bankLocations
            self.tableView.reloadData()
        }
        refreshControl.endRefreshing()
    }
    
    func getDataForLithuania() {
        let nm = NetworkManger()
        nm.getPosts(country: .lithuania, url: Country.lithuania.url) { (bankLocations, regions) in
            self.regionsLithuania = regions
            self.bankLocationsLithuania = bankLocations
            self.tableView.reloadData()
        }
        nm.retriveDataFromJsonFile(Country.lithuania.name) { (bankLocations, regions) in
            self.regionsLithuania = regions
            self.bankLocationsLithuania = bankLocations
            self.tableView.reloadData()
        }
        refreshControl.endRefreshing()
    }
}

extension RegionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let categoryEstonia = regionsEstonia[indexPath.row]
            let vc = ListViewController(items: filterRegions(bankLocation: bankLocationsEstonia, by: categoryEstonia))
            vc.title = categoryEstonia
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == 1 {
            let categoryLatvia = regionsLatvia[indexPath.row]
            let vc = ListViewController(items: filterRegions(bankLocation: bankLocationsLatvia, by: categoryLatvia))
            vc.title = categoryLatvia
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == 2 {
            let categoryLithuania = regionsLithuania[indexPath.row]
            let vc = ListViewController(items: filterRegions(bankLocation: bankLocationsLithuania, by: categoryLithuania))
            vc.title = categoryLithuania
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func filterRegions(bankLocation: [BankLocations], by region: String) -> [BankLocations] {
        return bankLocation.filter { $0.r == region }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        if section == 0 {
            label.text = Country.estonia.name
            label.backgroundColor = UIColor.lightGray
            return label
        } else if section == 1 {
            label.text = Country.latvia.name
            label.backgroundColor = UIColor.lightGray
            return label
        } else if section == 2 {
            label.text = Country.lithuania.name
            label.backgroundColor = UIColor.lightGray
            return label
        }
        return label
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
}

extension RegionsViewController: UITableViewDataSource { 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return regionsEstonia.count
        } else if section == 1 {
            return regionsLatvia.count
        } else if section == 2 {
            return regionsLithuania.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = indexPath.section == 0 ? regionsEstonia[indexPath.row] : (indexPath.section == 1 ? regionsLatvia[indexPath.row] : regionsLithuania[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

