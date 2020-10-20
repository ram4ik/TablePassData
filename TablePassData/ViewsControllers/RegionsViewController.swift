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
    private var timeCounter = TimeCounter()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        refreshControl.attributedTitle = NSAttributedString(string: timeCounter.canRefresh() ? "Pull to refresh" : "Try in an hour")
    }
    
    @objc func refresh(_ sender: AnyObject) {
        if timeCounter.canRefresh() {
            reloadData()
            timeCounter.saveCurrentTime()
        } else {
            refreshControl.endRefreshing()
        }
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
        let storage = Storage()
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
        storage.saveData(sections: sections)
        tableView.reloadData()
    }
}

extension RegionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ListViewController(items: sections[indexPath.section].regions[indexPath.row].points)
        vc.title = sections[indexPath.section].regions[indexPath.row].name
        navigationController?.pushViewController(vc, animated: true)
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

