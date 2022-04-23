//
//  SimpleTimerViewController.swift
//  HookahTimer
//
//  Created by Roman Doronin on 23.04.2022.
//

import UIKit

class SimpleTimerViewController: UIViewController {

    private let centralButton = UIButton()
    
    private var stopAnimating: Bool = false

    private var smokeImageView: UIImageView?

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
                self.centralButton.titleLabel?.font = .boldSystemFont(ofSize: Сonstants.timeFontSize)
            }
        } completion: { _ in
            if self.timer != nil {
                self.showSmoke()
            }
        }

        if timer != nil {
            hideSmoke()
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
    
    enum Сonstants {
        static let centralButtonDefaultTitle = "Начинаем курить"
        static let centralButtonSize: CGFloat = 300
        static let centralButtonBorderWidth: CGFloat = 3
        static let timeFontSize: CGFloat = 60
    }

    func setupCentralButton() {
        centralButton.setTitle(Сonstants.centralButtonDefaultTitle, for: .normal)
        centralButton.titleLabel?.font = .boldSystemFont(ofSize: 28)
        centralButton.backgroundColor = .black
        centralButton.layer.cornerRadius = Сonstants.centralButtonSize / 2
        centralButton.layer.borderColor = UIColor.white.cgColor
        centralButton.layer.borderWidth = Сonstants.centralButtonBorderWidth

        centralButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }

    func showSmoke() {
        guard smokeImageView == nil else {
            stopAnimating = false
            return
        }

        createSmokeImageView()
        guard let smokeImageView = smokeImageView else { return }
        view.addSubview(smokeImageView)
        smokeImageView.pinToSuperviewEdges()

        centralButton.removeFromSuperview()
        view.addSubview(centralButton)
        centralButton.pinToSuperviewCenter()

        stopAnimating = false
        animateSmoke()
    }

    func animateSmoke() {
        UIView.animate(withDuration: 3.0) {
            self.smokeImageView?.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: 3.0, delay: 12.0) {
                self.smokeImageView?.alpha = 0
            } completion: { _ in
                if self.stopAnimating {
                    self.smokeImageView?.removeFromSuperview()
                    self.smokeImageView = nil
                } else {
                    self.animateSmoke()
                }
            }
        }
    }

    func hideSmoke() {
        stopAnimating = true
    }

    func setupLayout() {
        [
            centralButton
        ].forEach {
            view.addSubview($0)
            $0.prepareForAutoLayout()
        }

        centralButton.pinToSuperviewCenter()
        centralButton.widthAnchor ~= Сonstants.centralButtonSize
        centralButton.heightAnchor ~= Сonstants.centralButtonSize
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

    func createSmokeImageView() {
        let smokeGif = UIImage.gifImageWithName("smoke")
        let imageView = UIImageView(image: smokeGif).prepareForAutoLayout()
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0
        smokeImageView = imageView
    }

}
