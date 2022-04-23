//
//  CheckBoxCell.swift
//  HookahTimer
//
//  Created by Roman Doronin on 23.04.2022.
//

import UIKit
import Lottie

class CheckBoxCell: UITableViewCell {

    var isChoosed: Bool = false {
        didSet {
            switch (oldValue, isChoosed) {
            case (false, true):
                checkBoxAnimationView.play(toFrame: 60)
            case (true, false):
                checkBoxAnimationView.play()
            default:
                break
            }
        }
    }

    private let checkBoxAnimationView: AnimationView = {
        let animationView = AnimationView(name: "checkBoxAnimation_black")
        animationView.loopMode = .playOnce
        return animationView
    }()

    func configurate(title: String) {
        textLabel?.text = title
        textLabel?.font = .boldSystemFont(ofSize: 24)

        contentView.addSubview(checkBoxAnimationView)
        checkBoxAnimationView.prepareForAutoLayout()
        checkBoxAnimationView.rightAnchor ~= contentView.rightAnchor - 20
        checkBoxAnimationView.topAnchor ~= contentView.topAnchor + 20
        checkBoxAnimationView.bottomAnchor ~= contentView.bottomAnchor - 20

        let checkBoxAnimationViewSize: CGFloat = 30
        checkBoxAnimationView.heightAnchor ~= checkBoxAnimationViewSize
        checkBoxAnimationView.widthAnchor ~= checkBoxAnimationViewSize
        
        checkBoxAnimationView.tintColor = .white
    }

}
