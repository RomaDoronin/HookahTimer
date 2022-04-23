//
//  SimpleTimerViewController.swift
//  HookahTimer
//
//  Created by Roman Doronin on 23.04.2022.
//

import UIKit

class SimpleTimerViewController: UIViewController {

    private let timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white

        return label
    }()

    private var curruntSeconds: Int = 0

    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        timerLabel.text = intToTextSeconds()
        setupLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
    }

}

// MARK: - Private

private extension SimpleTimerViewController {

    @objc
    func updateTimer() {
        curruntSeconds += 1
        timerLabel.text = intToTextSeconds()
    }

    func intToTextSeconds() -> String {
        let minutes = curruntSeconds / 60
        let seconds = curruntSeconds % 60
        guard minutes < 60 else {
            curruntSeconds = 0
            return intToTextSeconds()
        }
        let minutesString: String = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let secondsString: String = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        return "\(minutesString):\(secondsString)"
    }

    func setupLayout() {
        [
            timerLabel
        ].forEach {
            view.addSubview($0)
            $0.prepareForAutoLayout()
        }

        timerLabel.pinToSuperviewCenter()
    }

}
