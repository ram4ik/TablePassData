//
//  ViewController.swift
//  TablePassData
//
//  Created by ramil on 09.10.2020.
//

import UIKit

class RegionsViewController: UIViewController {
    
    var refreshControl = UIRefreshControl()
    
    private var sections = [Section]()
    private var network = Network()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        let _ = Timer.scheduledTimer(timeInterval: 3600, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        reloadData()
    }
    
    @objc func update() {
        reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func reloadData() {
        let group = DispatchGroup()
        
        sections.removeAll()
        refreshControl.beginRefreshing()
        defer { refreshControl.endRefreshing() }
        
        Country.allCases.forEach { [weak self] country in
        
            group.enter()
            let request = Api.getBAvkPointsRequest(country: country)
            network.getPosts(request) { result in
                
                defer { group.leave() }
                
                guard case .success(let locations) = result else {
                    return
                }
                
                var regions = [Region]()
                
                locations.forEach { point in
                    
                    if let district = regions.first(where: { $0.name == point.r }) {
                        district.points.append(point)
                    } else {
                        regions.append(.init(name: point.r ?? "N/A", points: [point]))
                    }
                }
                self?.sections.append(.init(country: country, regions: regions.sorted(by: { $0.name < $1.name })))
            }
        }
        
        group.wait()
        
        sections.sort(by: { $0.country.name < $1.country.name })
        tableView.reloadData()
    }
}

extension RegionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        if indexPath.section == 0 {
//            let categoryEstonia = regionsEstonia[indexPath.row]
//            let vc = ListViewController(items: filterRegions(bankLocation: bankLocationsEstonia, by: categoryEstonia))
//            vc.title = categoryEstonia
//            navigationController?.pushViewController(vc, animated: true)
//        } else if indexPath.section == 1 {
//            let categoryLatvia = regionsLatvia[indexPath.row]
//            let vc = ListViewController(items: filterRegions(bankLocation: bankLocationsLatvia, by: categoryLatvia))
//            vc.title = categoryLatvia
//            navigationController?.pushViewController(vc, animated: true)
//        } else if indexPath.section == 2 {
//            let categoryLithuania = regionsLithuania[indexPath.row]
//            let vc = ListViewController(items: filterRegions(bankLocation: bankLocationsLithuania, by: categoryLithuania))
//            vc.title = categoryLithuania
//            navigationController?.pushViewController(vc, animated: true)
//        }
    }
    
    func filterRegions(bankLocation: [BankPoint], by region: String) -> [BankPoint] {
        return bankLocation.filter { $0.r == region }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = sections[section].country.name
        label.backgroundColor = UIColor.lightGray
        return label
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
}

extension RegionsViewController: UITableViewDataSource { 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].regions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let district = sections[indexPath.section].regions[indexPath.row]
        cell.textLabel?.text = district.name 
        return cell
    }
}

