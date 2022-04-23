//
//  ChooseSmokers.swift
//  HookahTimer
//
//  Created by Roman Doronin on 23.04.2022.
//

import UIKit

class ChooseSmokersViewController: UIViewController {

    private let tableView = UITableView()

    private let defaultSmokersList = [
        "Рома",
        "Влад",
        "Никита",
        "Женя",
        "Тигран"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupNavigationBar()
    }

}

// MARK: - UITableViewDelegate

extension ChooseSmokersViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let checkBoxCell = tableView.cellForRow(at: indexPath) as? CheckBoxCell {
            checkBoxCell.isChoosed.toggle()
        }
    }

}

// MARK: - UITableViewDataSource

extension ChooseSmokersViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        defaultSmokersList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! CheckBoxCell
        cell.configurate(title: defaultSmokersList[indexPath.row])
        return cell
    }

}

// MARK: - Private

private extension ChooseSmokersViewController {

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        tableView.register(CheckBoxCell.self, forCellReuseIdentifier: "tableViewCell")

        view.addSubview(tableView)
        tableView.prepareForAutoLayout()
        tableView.pinToSuperviewEdges()
    }

    func setupNavigationBar() {
        navigationItem.title = "Выберите кто сегодня курит"
    }

}
