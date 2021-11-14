//
//  DetailInfoCell.swift
//  ccdd
//
//  Created by Zakirov Tahir on 12.11.2021.
//

import UIKit

class DetailInfoCell: UITableViewCell {
    
    var iconView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    var contactLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16)
        return view
    }()
   
    var birthdayLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemGray
        view.font = UIFont.systemFont(ofSize: 16)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDisplayViews()
        setupConstaints()
    }
    
    private func setupDisplayViews() {
        addSubview(iconView)
        addSubview(contactLabel)
        addSubview(birthdayLabel)
    }
    
    private func setupConstaints() {
        iconView.anchor(top: nil,
                        leading: leadingAnchor,
                        bottom: nil,
                        trailing: contactLabel.leadingAnchor,
                        padding: .init(top: 0, left: 16, bottom: 0, right: 14),
                        size: .init(width: 20, height: 20))
        
        iconView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        contactLabel.anchor(top: nil,
                            leading: nil,
                            bottom: nil,
                            trailing: birthdayLabel.leadingAnchor,
                            padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                            size: .init(width: 0, height: 0))
        
        contactLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        birthdayLabel.anchor(top: nil,
                             leading: contactLabel.trailingAnchor,
                             bottom: nil,
                             trailing: trailingAnchor,
                             padding: .init(top: 0, left: 0, bottom: 0, right: 20),
                             size: .init(width: 0, height: 0))
        
        birthdayLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
