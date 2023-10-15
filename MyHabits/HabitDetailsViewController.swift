//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Sergey on 22.08.2023.
//

import UIKit

final class HabitDetailsViewController: UIViewController {
    
    private var habit: Habit
        
    private var activityTable: UITableView = {
        
        var tableView = UITableView.init(
            frame: .zero,
            style: .grouped
        )
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private enum CellReuseID: String {
        case activityDate = "ActivityDateTableViewCell_ReauseID"
    }
    
    init(habit: Habit){
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tuneView()
        setupSubview()
        tuneTableCell()
        setupConstraints()
    }
    
    private func tuneView() {
        
        view.backgroundColor = .white
        title = habit.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Править",
            style: .plain,
            target: self,
            action: #selector(touchEdit)
        )
    }
    
    @objc private func touchEdit() {
        let view = HabitView_createController(habit: habit)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    private func setupSubview() {
        view.addSubview(activityTable)
    }
    
    private func tuneTableCell() {
        
        activityTable.backgroundColor = .white
        activityTable.rowHeight = UITableView.automaticDimension
        activityTable.estimatedRowHeight = 44.0
        activityTable.register(
            DetailsTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.activityDate.rawValue
        )
        
        activityTable.dataSource = self
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            activityTable.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            activityTable.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            activityTable.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            activityTable.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
}

// MARK: - Extension

extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {return HabitsStore.shared.dates.count}
        
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseID.activityDate.rawValue,
            for: indexPath
        )
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let date = HabitsStore.shared.dates[indexPath.row]
        let reversedIndex = HabitsStore.shared.dates.count - 1 - indexPath.row

        cell.textLabel?.text = HabitsStore.shared.trackDateString(forIndex: reversedIndex)
        cell.accessoryType = HabitsStore.shared.habit(habit, isTrackedIn: date) ? .checkmark : .none

        return cell
        }
    }
