//
//  DetailsViewController.swift
//  TablePassData
//
//  Created by Ramill Ibragimov on 09.10.2020.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private let items: BankLocations
    
    init(items: BankLocations) {
        self.items = items
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let type = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 50))
        type.center = CGPoint(x: UIScreen.main.bounds.width / 4 * 0.7, y: (UIScreen.main.bounds.height / 2) - 200)
        type.textAlignment = .right
        type.text = "Type"
        type.font = UIFont.systemFont(ofSize: 12.0)
        type.textColor = UIColor.secondaryLabel
        self.view.addSubview(type)
        
        let typeValue = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        typeValue.center = CGPoint(x: UIScreen.main.bounds.width / 4 * 3 - 20, y: (UIScreen.main.bounds.height / 2) - 200)
        typeValue.textAlignment = .left
        typeValue.numberOfLines = 0
        typeValue.text = (items.t == 0 ? "Branch" : (items.t == 1 ? "ATM" : "BNA"))
        self.view.addSubview(typeValue)
        
        let name = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 50))
        name.center = CGPoint(x: UIScreen.main.bounds.width / 4 * 0.7, y: (UIScreen.main.bounds.height / 2) - 150)
        name.textAlignment = .right
        name.text = "NAME"
        name.font = UIFont.systemFont(ofSize: 12.0)
        name.textColor = UIColor.secondaryLabel
        self.view.addSubview(name)
        
        let nameValue = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        nameValue.center = CGPoint(x: UIScreen.main.bounds.width / 4 * 3 - 20, y: (UIScreen.main.bounds.height / 2) - 150)
        nameValue.textAlignment = .left
        nameValue.numberOfLines = 0
        nameValue.text = items.n
        self.view.addSubview(nameValue)
        
        let address = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 50))
        address.center = CGPoint(x: UIScreen.main.bounds.width / 4 * 0.7, y: (UIScreen.main.bounds.height / 2) - 100)
        address.textAlignment = .right
        address.text = "ADDRESS"
        address.font = UIFont.systemFont(ofSize: 12.0)
        address.textColor = UIColor.secondaryLabel
        self.view.addSubview(address)
        
        let addressValue = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        addressValue.center = CGPoint(x: UIScreen.main.bounds.width / 4 * 3 - 20, y: (UIScreen.main.bounds.height / 2) - 100)
        addressValue.textAlignment = .left
        addressValue.numberOfLines = 0
        addressValue.text = items.a
        self.view.addSubview(addressValue)
        
        let region = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 50))
        region.center = CGPoint(x: UIScreen.main.bounds.width / 4 * 0.7, y: (UIScreen.main.bounds.height / 2) - 50)
        region.textAlignment = .right
        region.text = "REGION"
        region.font = UIFont.systemFont(ofSize: 12.0)
        region.textColor = UIColor.secondaryLabel
        self.view.addSubview(region)
        
        let regionValue = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        regionValue.center = CGPoint(x: UIScreen.main.bounds.width / 4 * 3 - 20, y: (UIScreen.main.bounds.height / 2) - 50)
        regionValue.textAlignment = .left
        regionValue.numberOfLines = 0
        regionValue.text = items.r
        self.view.addSubview(regionValue)
        
        if let availabilityData = items.av {
            let availability = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 150))
            availability.center = CGPoint(x: UIScreen.main.bounds.width / 4 * 0.7, y: (UIScreen.main.bounds.height / 2) + 50)
            availability.textAlignment = .right
            availability.text = "AVAILABILITY"
            availability.font = UIFont.systemFont(ofSize: 12.0)
            availability.textColor = UIColor.secondaryLabel
            self.view.addSubview(availability)
            
            let availabilityValue = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 150))
            availabilityValue.center = CGPoint(x: UIScreen.main.bounds.width / 4 * 3 - 20, y: (UIScreen.main.bounds.height / 2) + 50)
            availabilityValue.textAlignment = .left
            availabilityValue.numberOfLines = 0
            availabilityValue.text = availabilityData
            self.view.addSubview(availabilityValue)
        }
        
        if let infoData = items.i {
            let info = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 150))
            info.center = CGPoint(x: UIScreen.main.bounds.width / 4 * 0.7, y: (UIScreen.main.bounds.height / 2) + 150)
            info.textAlignment = .right
            info.text = "INFO"
            info.font = UIFont.systemFont(ofSize: 12.0)
            info.textColor = UIColor.secondaryLabel
            self.view.addSubview(info)
            
            let infoValue = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 150))
            infoValue.center = CGPoint(x: UIScreen.main.bounds.width / 4 * 3 - 20, y: (UIScreen.main.bounds.height / 2) + 150)
            infoValue.textAlignment = .left
            infoValue.numberOfLines = 0
            infoValue.text = infoData
            self.view.addSubview(infoValue)
        }
    }
    
}
