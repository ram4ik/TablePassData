//
//  ListViewController.swift
//  TablePassData
//
//  Created by ramil on 09.10.2020.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let items: [BankLocations]
    
    init(items: [BankLocations]) {
        self.items = items
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = items[indexPath.row].n
        cell.detailTextLabel?.text = items[indexPath.row].a
        cell.imageView!.image = UIImage(named: (items[indexPath.row].t == 0 ? "br" : (items[indexPath.row].t == 1 ? "a" : "r")))
        cell.imageView?.layer.cornerRadius = 25.0
        cell.imageView?.layer.masksToBounds = true
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let dvc = DetailsViewController(items: items[indexPath.row])
        dvc.title = items[indexPath.row].n
        navigationController?.pushViewController(dvc, animated: true)
    }
}
