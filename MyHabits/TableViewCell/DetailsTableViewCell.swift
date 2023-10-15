//
//  DetailsTableViewCell.swift
//  MyHabits
//
//  Created by Sergey on 04.09.2023.
//

import UIKit

final class DetailsTableViewCell: UITableViewCell {
    
//    private let dateText: UITextField = {
//        
//        let text = UITextField()
//        text.font = UIFont.systemFont(ofSize: 17, weight: .regular)
//        text.text = "reer"
//        text.translatesAutoresizingMaskIntoConstraints = false
//        
//        return text
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
//        contentView.addSubview(dateText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            dateText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
//            dateText.heightAnchor.constraint(equalToConstant: 22),
//            dateText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            dateText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            dateText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11)
//        ])
//    }
}
