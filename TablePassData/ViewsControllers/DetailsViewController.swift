//
//  DetailsViewController.swift
//  TablePassData
//
//  Created by Ramill Ibragimov on 09.10.2020.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = UITableView.automaticDimension
        return table
    }()
    
    private let items: BankPoint
    
    private var details = [String]()
    private var infoDetails = [String]()
    
    init(items: BankPoint) {
        self.items = items
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createArrayWithDetails()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 470
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return details.count
        } else if section == 1 {
            return infoDetails.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell = UITableViewCell(style: .value2, reuseIdentifier: "cell")
        cell.detailTextLabel?.text = indexPath.section == 0 ? details[indexPath.row] : infoDetails[indexPath.row]
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = .byWordWrapping
        cell.detailTextLabel?.sizeToFit()
        cell.detailTextLabel?.textColor = UIColor.secondaryLabel
        cell.textLabel?.text = getTitleText(titleIndex: indexPath.row, sectionIndex: indexPath.section)
        cell.textLabel?.textColor = UIColor.secondaryLabel
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12.0)
        
        return cell
    }
    
    private func getTitleText(titleIndex: Int, sectionIndex: Int) -> String {
        var titleText = ""
        if sectionIndex == 0 {
            if titleIndex == 0 {
                titleText = "TYPE"
            } else if titleIndex == 1 {
                titleText = "NAME"
            } else if titleIndex == 2 {
                titleText = "ADDRESS"
            } else if titleIndex == 3 {
                titleText = "REGION"
            }
        } else if sectionIndex == 1 {
            if titleIndex == 0 {
                titleText = "AVAILABILITY"
            } else if titleIndex == 1 {
                titleText = "INFO"
            }
        }
        return titleText
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func createArrayWithDetails() {
        details = [
            (items.t == 0 ? "Branch" : (items.t == 1 ? "ATM" : "BNA")),
            items.n,
            items.a
        ]
        
        if let r = items.r {
            details.append(r)
        }
        
        if let av = items.av {
            infoDetails.append(av)
        }
        
        if let i = items.i {
            infoDetails.append(i)
        }
    }
}
