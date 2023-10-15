//
//  HabitView_createController.swift
//  MyHabits
//
//  Created by Sergey on 28.08.2023.
//

import UIKit

final class HabitView_createController: UIViewController {
    
    private var habit: Habit?
    
// MARK: - Subviews
    
    private var contentView: UIView = {
        var contentView = UIView()
        
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    private var habitName: UILabel = {
        
        var label = UILabel()
        
        label.text = "НАЗВАНИЕ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var habitNameEnter: UITextField = {
        
        var nameEnter = UITextField()
        
        nameEnter.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        nameEnter.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        nameEnter.translatesAutoresizingMaskIntoConstraints = false
        
        return nameEnter
    }()
    
    private var selectColor: UILabel = {
        var title = UILabel()
        
        title.text = "ЦВЕТ"
        title.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    private var colorButton: UIButton = {
        var colorButton = UIButton()
        
        colorButton.frame.size = CGSize(width: 30, height: 30)
        colorButton.clipsToBounds = true
        colorButton.layer.cornerRadius = colorButton.frame.size.width/2
        colorButton.backgroundColor = .yellow
        colorButton.addTarget(self, action: #selector(pressColorButton), for: .touchUpInside)
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        
        return colorButton
    }()
    
    private var timeTitle: UILabel = {
        var title = UILabel()
        
        title.text = "ВРЕМЯ"
        title.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    private var timeLabel: UILabel = {
        var label = UILabel()
        
        label.text = "Каждый день в "
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var timeChange: UILabel = {
        var label = UILabel()

        label.textColor = .magenta
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var timePicker: UIDatePicker = {
        var timePicker = UIDatePicker()
        
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        
        return timePicker
    }()
    
    private lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(timeChange)
        
        return stackView
    }()
    
    private var deletHabit: UIButton = {
        let button = UIButton()
        
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        
        return button
    }()
    
// MARK: - Lifecycle
    
    init(habit: Habit?) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        tuneView()
        setupSubviews()
        setupConstraints()
        initHabit()
        
        timePicker.addTarget(self, action: #selector(timePickerValueChanged), for: .valueChanged)
    }
    
// MARK: - Private
    
    private func tuneView() {
        view.backgroundColor = .white
        title = "Создать"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Cохранить",
            style: .plain,
            target: self,
            action: #selector(pressSave)
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Отменить",
            style: .plain,
            target: self,
            action: #selector(pressCancel)
        )
    }
    
    private func initHabit() {
        guard let habit = self.habit else {
            self.navigationItem.title = "Создать"
            deletHabit.isHidden = true
            return
        }
        habitNameEnter.text = habit.name
        colorButton.backgroundColor = habit.color
        timeChange.text = habit.dateString
        self.navigationItem.title = "Изменить"
        deletHabit.isHidden = false
    }
    
    @objc private func timePickerValueChanged() {
        updateTimeLabel()
    }
    
    private func updateTimeLabel() {
        let time = DateFormatter()
        time.dateFormat = "HH:mm"
        let  selectedTime = timePicker.date
        timeChange.text = time.string(from: selectedTime)
    }
    
    @objc private func pressSave() {
        
        guard let habit = self.habit else {
            
            let newHabit = Habit(name: habitNameEnter.text ?? "Введите название привычки",
                                 date: timePicker.date,
                                 color: colorButton.backgroundColor ?? .black)
            let store = HabitsStore.shared
            store.habits.append(newHabit)
            
            self.dismiss(animated: true)
            
            return
        }
        
        habit.name = habitNameEnter.text!
        habit.color = colorButton.backgroundColor!
        habit.date = timePicker.date
        
        if let index = HabitsStore.shared.habits.firstIndex(where: {$0 == habit}) {
            HabitsStore.shared.habits[index].name = habit.name
            HabitsStore.shared.habits[index].color = habit.color
            HabitsStore.shared.habits[index].date = habit.date
        }
        HabitsStore.shared.save()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func pressCancel() {
        guard let habit = self.habit else {
            self.dismiss(animated: true)
            return
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func pressColorButton() {
        presentColoPicker()
    }
    
    @objc private func deleteTapped() {
        
        let alert = UIAlertController(
            title: "Удалить привычку",
            message: "Вы хотите удалить привычку \"\(habit!.name)\"",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) {_ in
            self.deleteHabit(habit: Habit(name: self.habit!.name, date: self.habit!.date, color: self.habit!.color ))
        }
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        present(alert, animated: true)
    }
    
    private func presentColoPicker() {
        
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true)
    }
    
    private func deleteHabit(habit: Habit) {
        
        if let index = HabitsStore.shared.habits.firstIndex(
            where: { $0.name == habit.name && $0.date == habit.date && $0.color == habit.color}
        ) {
            HabitsStore.shared.habits.remove(at: index)
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    private func setupSubviews() {
        view.addSubview(contentView)
        contentView.addSubview(habitName)
        contentView.addSubview(habitNameEnter)
        contentView.addSubview(selectColor)
        contentView.addSubview(colorButton)
        contentView.addSubview(timeTitle)
        contentView.addSubview(stackView)
        contentView.addSubview(timePicker)
        contentView.addSubview(deletHabit)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor),
            
            habitName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21),
            habitName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            habitName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            habitNameEnter.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 46),
            habitNameEnter.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            habitName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            selectColor.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 83),
            selectColor.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            selectColor.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            colorButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 108),
            colorButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            
            timeTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 153),
            timeTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            timeTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 178),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            
            timePicker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 215),
            timePicker.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            timePicker.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            deletHabit.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 638),
            deletHabit.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}

// MARK: - Extension

extension HabitView_createController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        self.colorButton.backgroundColor = viewController.selectedColor
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        print("color did finish")
    }
}
