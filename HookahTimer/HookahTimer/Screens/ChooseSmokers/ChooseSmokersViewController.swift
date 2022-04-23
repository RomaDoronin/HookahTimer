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
        
    }

}

// MARK: - UITableViewDataSource

extension ChooseSmokersViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        defaultSmokersList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        if let textLabel = cell.textLabel {
            textLabel.text = defaultSmokersList[indexPath.row]
        }
        return cell
    }

}

// MARK: - Private

private extension ChooseSmokersViewController {

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.prepareForAutoLayout()
        tableView.pinToSuperviewEdges()
    }

    func setupNavigationBar() {
        navigationItem.title = "Выберите кто сегодня курит"
    }

}
