//
//  ChooseSmokers.swift
//  HookahTimer
//
//  Created by Roman Doronin on 23.04.2022.
//

import UIKit

class ChooseSmokersViewController: UIViewController {

    private let tableView = UITableView()
    private let nextButton = UIButton()

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
        setupNextButton()
        setupLayout()
    }

}

// MARK: - UITableViewDelegate

extension ChooseSmokersViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let checkBoxCell = tableView.cellForRow(at: indexPath) as? CheckBoxCell {
            checkBoxCell.isChoosed.toggle()
            updateNextButtonStatus()
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

// MARK: - Actions

private extension ChooseSmokersViewController {
    
    @objc
    func nextButtonTapped() {
        let viewController = SimpleTimerViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: false)
    }
    
}

// MARK: - Private

private extension ChooseSmokersViewController {
    
    func updateNextButtonStatus() {
        for row in 0...defaultSmokersList.count {
            if let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? CheckBoxCell {
                if cell.isChoosed {
                    nextButton.isEnabled = true
                    return
                }
            }
        }

        nextButton.isEnabled = false
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        tableView.register(CheckBoxCell.self, forCellReuseIdentifier: "tableViewCell")
    }

    func setupNavigationBar() {
        navigationItem.title = "Выберите кто сегодня курит"
    }

    func setupNextButton() {
        nextButton.setTitle("Дальше", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.setTitleColor(.gray, for: .highlighted)
        nextButton.setTitleColor(.darkGray, for: .disabled)
        nextButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        nextButton.isEnabled = false

        nextButton.layer.cornerRadius = 10
        nextButton.layer.borderColor = UIColor.white.cgColor
        nextButton.layer.borderWidth = 3

        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }

    func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(nextButton)

        [
            tableView,
            nextButton,
        ].forEach {
            $0.prepareForAutoLayout()
        }

        tableView.pinToSuperviewEdges()

        let edgeButtonSpace: CGFloat = 60
        nextButton.leftAnchor ~= tableView.leftAnchor + edgeButtonSpace
        nextButton.rightAnchor ~= tableView.rightAnchor - edgeButtonSpace
        nextButton.bottomAnchor ~= view.safeAreaLayoutGuide.bottomAnchor - 20
        nextButton.heightAnchor ~= 60
    }

}
