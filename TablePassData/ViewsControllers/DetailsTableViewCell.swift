//
//  DetailsTableViewCell.swift
//  TablePassData
//
//  Created by ramil on 19.10.2020.
//

import UIKit

class DetailsTableViewCell {
    
    func configure(cell: UITableViewCell, indexPath: IndexPath) {
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = .byWordWrapping
        cell.detailTextLabel?.sizeToFit()
        cell.detailTextLabel?.textColor = UIColor.secondaryLabel
       
        cell.textLabel?.text = getTitleText(titleIndex: indexPath.row, sectionIndex: indexPath.section)
        cell.textLabel?.textColor = UIColor.secondaryLabel
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12.0)
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
}
