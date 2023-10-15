//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Sergey on 08.08.2023.
//

import UIKit

final class HabitsViewController: UIViewController {
  
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView.init(
            frame: .zero,
            style: .plain
        )
        
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()
    
    private enum CellReuseID: String {
        case status = "StatusTableViewCell_ReauseID"
        case base = "BaseTableViewCell_ReauseID"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        tuneTableView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.reloadData()
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        navigationItem.title = "Сегодня"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(pressButton)
        )
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "customPurple")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc private func pressButton () {
        
        let view = HabitView_createController(habit: nil)
        let navigationController = UINavigationController(rootViewController: view)
        
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
    
    private func tuneTableView() {
        
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.separatorStyle = .none

        tableView.register(
            ProgressCollectionViewCell.self,
            forCellReuseIdentifier: CellReuseID.status.rawValue)
        
        tableView.register(
            BaseTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.base.rawValue
        )
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - Extension

extension HabitsViewController: UITableViewDataSource {
    
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        2
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        if section == 0 {
           return 1
        } else {return HabitsStore.shared.habits.count}
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.status.rawValue,
                for: indexPath
            ) as? ProgressCollectionViewCell else {
                fatalError("could not dequeueReusableCell")
            }
            cell.accessoryType = .none
            cell.updateProgress()
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.base.rawValue,
                for: indexPath
            ) as? BaseTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
            cell.accessoryType = .none
            cell.update(HabitsStore.shared.habits[indexPath.row])
            cell.delegate = self

            return cell
        }
    }
}

extension HabitsViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        if indexPath.section == 0 {
            return 102
        } else { return 142}
//        UITableView.automaticDimension
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        if indexPath.section == 1 {
            let infoView = HabitDetailsViewController(
                habit: HabitsStore.shared.habits[indexPath.row]
            )
            
            navigationController?.pushViewController(
                infoView,
                animated: true
            )
        } else {return}
    }
}

extension HabitsViewController: BaseTableViewCellDelegate {

    func didTapCheckButton(inCell cell: BaseTableViewCell) {
//        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        tableView.reloadData()
    }
}
