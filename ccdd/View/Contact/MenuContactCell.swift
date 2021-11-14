//
//  MenuContactCell.swift
//  ccdd
//
//  Created by Zakirov Tahir on 14.11.2021.
//

import UIKit

class MenuContactCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 15)
        view.textColor = .systemGray
        view.textAlignment = .center
        return view
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 101 / 255, green: 52 / 255, blue: 255 / 255, alpha: 1)
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            self.lineView.isHidden = isSelected ? false : true
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDisplayViews()
        setupConstaints()
    }
    
    private func setupDisplayViews() {
        addSubview(titleLabel)
        addSubview(lineView)
    }
    
    private func setupConstaints() {
        titleLabel.anchor(top: topAnchor,
                          leading: leadingAnchor,
                          bottom: lineView.topAnchor,
                          trailing: trailingAnchor,
                          padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                          size: .init(width: 0, height: 0))
        
        lineView.anchor(top: titleLabel.bottomAnchor,
                        leading: leadingAnchor,
                        bottom: bottomAnchor,
                        trailing: trailingAnchor,
                        padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                        size: .init(width: 0, height: 2))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
