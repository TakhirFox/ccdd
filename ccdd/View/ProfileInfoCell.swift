//
//  ProfileInfoCell.swift
//  ccdd
//
//  Created by Zakirov Tahir on 12.11.2021.
//

import UIKit

class ProfileInfoCell: UITableViewCell {
    
    var avatar: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 104 / 2
        view.clipsToBounds = true
        return view
    }()
    
    var fullName: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 24)
        return view
    }()
    
    var position: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13)
        view.textColor = .systemGray
        view.textAlignment = .center
        return view
    }()
    
    var userTag: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 17)
        view.textColor = .systemGray2
        return view
    }()
    
    var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalCentering
        view.spacing = 6
        view.alignment = .center
        return view
    }()
    
    var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 12
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupDisplayViews()
        setupConstaints()
    }
    
    func setupDisplayViews() {
        backgroundColor = .systemGray6

        addSubview(avatar)
        addSubview(stackView)
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(stackView)
        verticalStackView.addArrangedSubview(position)
        stackView.addArrangedSubview(fullName)
        stackView.addArrangedSubview(userTag)
    }
    
    func setupConstaints() {
        avatar.anchor(top: topAnchor,
                      leading: nil,
                      bottom: verticalStackView.topAnchor,
                      trailing: nil,
                      padding: .init(top: 16, left: 16, bottom: 24, right: 16),
                      size: .init(width: 104, height: 104))
        avatar.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        verticalStackView.anchor(top: avatar.bottomAnchor,
                                 leading: nil,
                                 bottom: nil,
                                 trailing: nil,
                                 padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                                 size: .init(width: 0, height: 0))
        verticalStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
