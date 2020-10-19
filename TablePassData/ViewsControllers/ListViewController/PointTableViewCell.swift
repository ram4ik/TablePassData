//
//  PointTableViewCell.swift
//  TablePassData
//
//  Created by ramil on 19.10.2020.
//

import UIKit

class PointTableViewCell {
    
    func configure(cell: UITableViewCell, item: BankPoint) {
        cell.textLabel?.text = item.n
        cell.detailTextLabel?.text = item.a
        cell.imageView!.image = UIImage(named: (item.t == 0 ? "br" : (item.t == 1 ? "a" : "r")))
        cell.imageView?.translatesAutoresizingMaskIntoConstraints = false
        let marginguide = cell.contentView.layoutMarginsGuide
        cell.imageView?.topAnchor.constraint(equalTo: marginguide.topAnchor).isActive = true
        cell.imageView?.leadingAnchor.constraint(equalTo: marginguide.leadingAnchor).isActive = true
        cell.imageView?.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cell.imageView?.widthAnchor.constraint(equalToConstant: 40).isActive = true
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.layer.cornerRadius = 20
        cell.imageView?.layer.masksToBounds = true
        cell.accessoryType = .disclosureIndicator
    }
}
