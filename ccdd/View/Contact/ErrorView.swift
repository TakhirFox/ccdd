//
//  ErrorView.swift
//  ccdd
//
//  Created by Zakirov Tahir on 14.11.2021.
//

import UIKit

class ErrorView: UIView {
    let searchImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "nloIcon")
        return view
    }()
    
    var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Какой-то сверхразум все сломал"
        view.font = UIFont.boldSystemFont(ofSize: 17)
        return view
    }()
    
    var subtitleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemGray
        view.text = "Постараемся быстро починить"
        view.font = UIFont.systemFont(ofSize: 16)
        return view
    }()
    
    var tryButton: UIButton = {
        let view = UIButton()
        view.setTitle("Попробовать снова", for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        view.setTitleColor(UIColor(red: 101 / 255, green: 52 / 255, blue: 255 / 255, alpha: 1), for: .normal)
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
        stackView.addArrangedSubview(tryButton)
        
        backgroundColor = .systemBackground
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
