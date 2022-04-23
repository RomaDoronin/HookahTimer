//
//  SimpleTimerViewController.swift
//  HookahTimer
//
//  Created by Roman Doronin on 23.04.2022.
//

import UIKit

class SimpleTimerViewController: UIViewController {

    private let centralButton = UIButton()
    private let centralButtonDefaultTitle = "Начинаем курить"
    private let centralButtonSize: CGFloat = 300

    private let smokeImageView: UIImageView = {
        let smokeGif = UIImage.gifImageWithName("smoke")
        let imageView = UIImageView(image: smokeGif)
        imageView.transform.rotated(by: .pi / 2)
        return imageView
    }()

    private var curruntSeconds: Int = 0
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCentralButton()
        setupLayout()
    }

}

// MARK: - Actions

private extension SimpleTimerViewController {

    @objc
    func startButtonTapped() {
        UIView.transition(with: centralButton, duration: 1.0, options: .transitionFlipFromTop) {
            if self.timer != nil {
                self.centralButton.setTitle("Начинаем курить", for: .normal)
                self.centralButton.titleLabel?.font = .boldSystemFont(ofSize: 28)
            } else {
                self.centralButton.setTitle(self.intToTextSeconds(), for: .normal)
                self.centralButton.titleLabel?.font = .boldSystemFont(ofSize: 60)
            }
        } completion: { _ in
            self.showSmoke()
        }

        if timer != nil {
            timer?.invalidate()
            timer = nil
            curruntSeconds = 0
        } else {
            timer = Timer.scheduledTimer(
                timeInterval: 1.0,
                target: self,
                selector: #selector(updateTimer),
                userInfo: nil,
                repeats: true
            )
        }
    }

    @objc
    func updateTimer() {
        curruntSeconds += 1
        self.centralButton.setTitle(self.intToTextSeconds(), for: .normal)
    }

}

// MARK: - Private

private extension SimpleTimerViewController {

    func setupCentralButton() {
        centralButton.setTitle(centralButtonDefaultTitle, for: .normal)
        centralButton.titleLabel?.font = .boldSystemFont(ofSize: 28)
        centralButton.backgroundColor = .black
        centralButton.layer.cornerRadius = centralButtonSize / 2
        centralButton.layer.borderColor = UIColor.white.cgColor
        centralButton.layer.borderWidth = 3

        centralButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    private func showSmoke() {
        view.addSubview(smokeImageView)
        smokeImageView.pinToSuperviewCenter()

        centralButton.removeFromSuperview()
        view.addSubview(centralButton)
        centralButton.pinToSuperviewCenter()

        UIView.animate(withDuration: 3.0, delay: 12.0) {
            self.smokeImageView.alpha = 0
        } completion: { _ in
            self.smokeImageView.removeFromSuperview()
            self.smokeImageView.alpha = 1
        }
    }

    func setupLayout() {
        [
            centralButton
        ].forEach {
            view.addSubview($0)
            $0.prepareForAutoLayout()
        }

        smokeImageView.prepareForAutoLayout()

        centralButton.pinToSuperviewCenter()
        centralButton.widthAnchor ~= centralButtonSize
        centralButton.heightAnchor ~= centralButtonSize
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

}
