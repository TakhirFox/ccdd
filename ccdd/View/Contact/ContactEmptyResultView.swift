//
//  ContactEmptyResultView.swift
//  ccdd
//
//  Created by Zakirov Tahir on 13.11.2021.
//

import UIKit

class ContactEmptyResultView: UIView {
    let searchImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "searchIcon")
        return view
    }()
    
    var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Мы никого не нашли"
        view.font = UIFont.boldSystemFont(ofSize: 17)
        return view
    }()
    
    var subtitleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemGray
        view.text = "Попробуй скорректировать запрос"
        view.font = UIFont.systemFont(ofSize: 16)
        return view
    }()
    
    var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 12
        view.alignment = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDisplayViews()
        setupConstaints()
    }
    
    private func setupDisplayViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(searchImage)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
    }
    
    private func setupConstaints() {
        stackView.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: nil,
                         trailing: trailingAnchor,
                         padding: .init(top: 220, left: 16, bottom: 0, right: 16),
                         size: .init(width: 0, height: 0))

        searchImage.widthAnchor.constraint(equalToConstant: 56).isActive = true
        searchImage.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
