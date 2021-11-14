//
//  ContactCell.swift
//  ccdd
//
//  Created by Zakirov Tahir on 05.11.2021.
//

import UIKit
import SkeletonView

class ContactCell: UICollectionViewCell {
    var avatar: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 72 / 2
        view.clipsToBounds = true
        view.isSkeletonable = true
        return view
    }()
    
    var fullName: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.lastLineFillPercent = 80
        view.linesCornerRadius = 7
        return view
    }()
    
    var position: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13)
        view.textColor = .systemGray
        view.isSkeletonable = true
        view.lastLineFillPercent = 80
        view.linesCornerRadius = 7
        return view
    }()
    
    var userTag: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = .systemGray2
        view.isSkeletonable = true
        view.lastLineFillPercent = 80
        view.linesCornerRadius = 7
        return view
    }()
    
    var birthday: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 15)
        view.textColor = .systemGray
        view.textAlignment = .right
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isSkeletonable = true
        setupDisplayViews()
        setupConstaints()
    }
    
    private func setupDisplayViews() {
        contentView.addSubview(avatar)
        contentView.addSubview(fullName)
        contentView.addSubview(userTag)
        contentView.addSubview(position)
        contentView.addSubview(birthday)
    }
    
    private func setupConstaints() {
        avatar.anchor(top: nil,
                      leading: leadingAnchor,
                      bottom: nil,
                      trailing: nil,
                      padding: .init(top: 16, left: 16, bottom: 6, right: 16),
                      size: .init(width: 72, height: 72))
        
        avatar.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        fullName.anchor(top: topAnchor,
                        leading: avatar.trailingAnchor,
                        bottom: position.topAnchor,
                        trailing: userTag.leadingAnchor,
                        padding: .init(top: frame.size.height / 2 - 20, left: 16, bottom: 2, right: 4),
                        size: .init(width: 0, height: 0))

        userTag.anchor(top: topAnchor,
                       leading: fullName.trailingAnchor,
                       bottom: position.topAnchor,
                       trailing: nil,
                       padding: .init(top: frame.size.height / 2 - 20, left: 4, bottom: 2, right: 4),
                       size: .init(width: 0, height: 0))
        
        position.anchor(top: nil,
                        leading: avatar.trailingAnchor,
                        bottom: bottomAnchor,
                        trailing: birthday.leadingAnchor,
                        padding: .init(top: 2, left: 16, bottom: frame.size.height / 2 - 15, right: 4),
                        size: .init(width: 0, height: 0))
        
        birthday.anchor(top: nil,
                        leading: userTag.trailingAnchor,
                        bottom: nil,
                        trailing: trailingAnchor,
                        padding: .init(top: 6, left: 0, bottom: 6, right: 16),
                        size: .init(width: 80, height: 0))
        birthday.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
