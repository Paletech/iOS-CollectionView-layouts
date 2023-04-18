//
//  TagCollectionViewCell.swift
//  TagCollectionViewCell
//
//  Created by LEMIN DAHOVICH on 10.04.2023.
//
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
        
    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildHierarchy()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config<Decorator: TagDecorator>(info: String, decorator: Decorator) {
        self.titleLabel.text = info
        decorator.applyDecoration(to: self)
    }
    
    private func buildHierarchy() {
        contentView.addSubview(view)
        view.addSubview(titleLabel)
    }
    
    private func setupView() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
