//
//  BaseTableViewCell.swift
//  MyHabits
//
//  Created by Sergey on 15.08.2023.
//

import UIKit

final class BaseTableViewCell: UITableViewCell {
    
    weak var delegate: BaseTableViewCellDelegate?
    
    private var habit: Habit?
    
    private let textHabit: UILabel = {
        var textHabbit = UILabel()
        
        textHabbit.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        textHabbit.translatesAutoresizingMaskIntoConstraints = false
        
        return textHabbit
    }()
    
    private let textTimeHabit: UILabel = {
        let textTimeHabit = UILabel()
        
        textTimeHabit.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        textTimeHabit.textColor = .systemGray2
        textTimeHabit.translatesAutoresizingMaskIntoConstraints = false
        
        return textTimeHabit
    }()
    
    private let counter: UITextField = {
        let counter = UITextField()
        
        counter.font = UIFont.systemFont(
            ofSize: 13,
            weight: .regular
        )
        counter.textColor = .systemGray
        counter.translatesAutoresizingMaskIntoConstraints = false
        
        return counter
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(
            self,
            action: #selector(touchCheckButton),
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: .value1,
            reuseIdentifier: reuseIdentifier
        )
        
        tuneView()
        setupSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16))
        contentView.layer.cornerRadius = 8
    }
    
    private func tuneView() {
        backgroundColor = UIColor(named: "customGrey")
        contentView.backgroundColor = .white
    }
    
    private func setupSubview() {
        contentView.addSubview(textHabit)
        contentView.addSubview(textTimeHabit)
        contentView.addSubview(counter)
        contentView.addSubview(checkButton)
    }
    
    @objc func touchCheckButton() {
        guard let habit else {
            return
        }
        if !habit.isAlreadyTakenToday {
            checkButton.setImage(
                UIImage(systemName: "checkmark.circle.fill"),
                for: .normal
            )
            HabitsStore.shared.track(habit)
        }
        HabitsStore.shared.save()
        delegate?.didTapCheckButton(inCell: self)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 130),
            
            textHabit.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            textHabit.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            textHabit.heightAnchor.constraint(equalToConstant: 22),
            
            textTimeHabit.topAnchor.constraint(equalTo: textHabit.bottomAnchor, constant: 4),
            textTimeHabit.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            textTimeHabit.heightAnchor.constraint(equalToConstant: 16),
            
            counter.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 92),
            counter.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            counter.heightAnchor.constraint(equalToConstant: 18),
            counter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            checkButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 46),
            checkButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            checkButton.heightAnchor.constraint(equalToConstant: 38),
            checkButton.widthAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    // MARK: - Public
    
    func update(_ model: Habit) {
        
        self.habit = model
        textHabit.text = model.name
        textHabit.textColor = model.color
        checkButton.tintColor = model.color
        
        textTimeHabit.text = model.dateString
        counter.text = "счетчик: \(model.trackDates.count)"
        
        checkButton.setImage(
            UIImage(systemName: model.isAlreadyTakenToday ? "checkmark.circle.fill" : "circle"),
            for: .normal
        )
    }
}

protocol BaseTableViewCellDelegate: AnyObject {
    func didTapCheckButton(inCell cell: BaseTableViewCell)
}
