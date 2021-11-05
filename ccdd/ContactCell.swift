//
//  ContactCell.swift
//  ccdd
//
//  Created by Zakirov Tahir on 05.11.2021.
//

import UIKit

class ContactCell: UITableViewCell {
    var avatar: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 72 / 2
        view.clipsToBounds = true
        return view
    }()
    
    var fullName: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 16)
        return view
    }()
    
    var position: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13)
        view.textColor = .systemGray
        return view
    }()
    
    var userTag: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = .systemGray2
        return view
    }()
    
    var birthday: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 15)
        view.textColor = .systemGray
        view.textAlignment = .right
        return view
    }()
    
    var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 6
        view.alignment = .center
        return view
    }()
    
    var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    var horizStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 6
        view.alignment = .center
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupDisplayViews()
        setupConstaints()
    }
    
    private func setupDisplayViews() {
        addSubview(stackView)
        addSubview(verticalStackView)
        stackView.addArrangedSubview(avatar)
        stackView.addArrangedSubview(verticalStackView)
        verticalStackView.addArrangedSubview(horizStackView)
        verticalStackView.addArrangedSubview(position)
        horizStackView.addArrangedSubview(fullName)
        horizStackView.addArrangedSubview(userTag)
        stackView.addArrangedSubview(birthday)
    }
    
    private func setupConstaints() {
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 6, left: 16, bottom: 6, right: 16))
        avatar.widthAnchor.constraint(equalToConstant: 72).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 72).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
