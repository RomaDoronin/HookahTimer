//
//  ViewController.swift
//  HookahTimer
//
//  Created by Roman Doronin on 23.04.2022.
//

import UIKit

class ViewController: UIViewController {

    let logoImageView: UIImageView = {
        let logoImage = UIImage(named: "logo")
        return UIImageView(image: logoImage)
    }()
    
    let headerLabel: UILabel
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .black
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }

}

// MARK: - Private

private extension ViewController {

    func setupLayout() {
        
    }

}
