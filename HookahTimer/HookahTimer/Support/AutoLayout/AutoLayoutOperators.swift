// Copyright © 2021 Инновационные сервисы. All rights reserved.

import UIKit

// MARK: - Structures

public struct ConstraintAttribute<T: AnyObject> {
    let anchor: NSLayoutAnchor<T>
    let constant: CGFloat
}

public struct LayoutGuideAttribute {
    let guide: UILayoutSupport
    let constant: CGFloat
}

// MARK: - Operators

public func + <T>(lhs: NSLayoutAnchor<T>, rhs: CGFloat) -> ConstraintAttribute<T> {
    ConstraintAttribute(anchor: lhs, constant: rhs)
}

public func + (lhs: UILayoutSupport, rhs: CGFloat) -> LayoutGuideAttribute {
    LayoutGuideAttribute(guide: lhs, constant: rhs)
}

public func - <T>(lhs: NSLayoutAnchor<T>, rhs: CGFloat) -> ConstraintAttribute<T> {
    ConstraintAttribute(anchor: lhs, constant: -rhs)
}

public func - (lhs: UILayoutSupport, rhs: CGFloat) -> LayoutGuideAttribute {
    LayoutGuideAttribute(guide: lhs, constant: -rhs)
}

@discardableResult
public func ~= (lhs: NSLayoutYAxisAnchor, rhs: UILayoutSupport) -> NSLayoutConstraint {
    lhs.constraint(equalTo: rhs.bottomAnchor).activate()
}

@discardableResult
public func ~= <T>(lhs: NSLayoutAnchor<T>, rhs: NSLayoutAnchor<T>) -> NSLayoutConstraint {
    lhs.constraint(equalTo: rhs).activate()
}

@discardableResult
public func <= <T>(lhs: NSLayoutAnchor<T>, rhs: NSLayoutAnchor<T>) -> NSLayoutConstraint {
    lhs.constraint(lessThanOrEqualTo: rhs).activate()
}

@discardableResult
public func >= <T>(lhs: NSLayoutAnchor<T>, rhs: NSLayoutAnchor<T>) -> NSLayoutConstraint {
    lhs.constraint(greaterThanOrEqualTo: rhs).activate()
}

@discardableResult
public func ~= <T>(lhs: NSLayoutAnchor<T>, rhs: ConstraintAttribute<T>) -> NSLayoutConstraint {
    lhs.constraint(equalTo: rhs.anchor, constant: rhs.constant).activate()
}

@discardableResult
public func ~= (lhs: NSLayoutYAxisAnchor, rhs: LayoutGuideAttribute) -> NSLayoutConstraint {
    lhs.constraint(equalTo: rhs.guide.bottomAnchor, constant: rhs.constant).activate()
}

@discardableResult
public func ~= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.constraint(equalToConstant: rhs).activate()
}

@discardableResult
public func <= <T>(lhs: NSLayoutAnchor<T>, rhs: ConstraintAttribute<T>) -> NSLayoutConstraint {
    lhs.constraint(lessThanOrEqualTo: rhs.anchor, constant: rhs.constant).activate()
}

@discardableResult
public func <= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.constraint(lessThanOrEqualToConstant: rhs).activate()
}

@discardableResult
public func >= <T>(lhs: NSLayoutAnchor<T>, rhs: ConstraintAttribute<T>) -> NSLayoutConstraint {
    lhs.constraint(greaterThanOrEqualTo: rhs.anchor, constant: rhs.constant).activate()
}

@discardableResult
public func >= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.constraint(greaterThanOrEqualToConstant: rhs).activate()
}
