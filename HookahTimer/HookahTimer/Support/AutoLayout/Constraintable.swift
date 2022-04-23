// Copyright © 2021 Инновационные сервисы. All rights reserved.

import UIKit

/// Протокол сущности, к которой можно применять констрейнты на anchor'ах
public protocol Constraintable {
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    var heightAnchor: NSLayoutDimension { get }
    var widthAnchor: NSLayoutDimension { get }
}

extension UIView: Constraintable {}
extension UILayoutGuide: Constraintable {}
