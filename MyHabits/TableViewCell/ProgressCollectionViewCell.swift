//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Sergey on 20.08.2023.
//

import UIKit

final class ProgressCollectionViewCell: UITableViewCell {
    
    // MARK: - Subviews
    
    private let statusText: UILabel = {
        let statusText = UILabel()
        
        statusText.text = "Всё получится!"
        statusText.textColor = .systemGray
        statusText.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        statusText.translatesAutoresizingMaskIntoConstraints = false
        
        return statusText
    }()
    
    private let persentText: UILabel = {
        let persent = UILabel()
        
        persent.textColor = .systemGray
        persent.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        persent.translatesAutoresizingMaskIntoConstraints = false
        
        return persent
    }()
    
    private let progressLine: UIProgressView = {
        let progressLine = UIProgressView()
        
        progressLine.progressTintColor = UIColor(named: "customPurple")
        progressLine.trackTintColor = .systemGray2
        progressLine.progressViewStyle = .default
        progressLine.progress = 0.3
        progressLine.translatesAutoresizingMaskIntoConstraints = false
        
        return progressLine
    }()
    
    // MARK: - Lifycycle
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: .value1,
            reuseIdentifier: reuseIdentifier
        )
        
        tuneView()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 22, left: 16, bottom: 20, right: 16))
        contentView.layer.cornerRadius = 8
    }
    
    // MARK: - Private
    
    private func tuneView() {
        backgroundColor = UIColor(named: "customGrey")
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .white
    }
    
    private func setupSubviews() {
        contentView.addSubview(statusText)
        contentView.addSubview(persentText)
        contentView.addSubview(progressLine)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 160),
            
            statusText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            statusText.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            statusText.heightAnchor.constraint(equalToConstant: 18),
            
            persentText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            persentText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            persentText.heightAnchor.constraint(equalToConstant: 18),
            
            progressLine.topAnchor.constraint(equalTo: statusText.bottomAnchor, constant: 10),
            progressLine.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            progressLine.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            progressLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            progressLine.heightAnchor.constraint(equalToConstant: 7)
        ])
    }
    
    // MARK: - Public
    
    func updateProgress() {
        persentText.text = String(Int((HabitsStore.shared.todayProgress)*100)) + "%"
        progressLine.progress = HabitsStore.shared.todayProgress
    }
}
