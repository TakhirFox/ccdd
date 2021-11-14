//
//  SortCell.swift
//  ccdd
//
//  Created by Zakirov Tahir on 10.11.2021.
//

import UIKit

class SortCell: UITableViewCell {
    
    let ratioImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "unselectedRatio")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let sortLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupDisplayViews()
        setupConstaints()
    }
    
    private func setupDisplayViews() {
        addSubview(ratioImageView)
        addSubview(sortLabel)
    }
    
    private func setupConstaints() {
        ratioImageView.anchor(top: topAnchor,
                              leading: leadingAnchor,
                              bottom: bottomAnchor,
                              trailing: sortLabel.leadingAnchor,
                              padding: .init(top: 10, left: 24, bottom: 10, right: 10),
                              size: .init(width: 20, height: 20))
        
        sortLabel.anchor(top: topAnchor,
                         leading: nil,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         padding: .init(top: 0, left: 0, bottom: 0, right: 24),
                         size: .init(width: 0, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
