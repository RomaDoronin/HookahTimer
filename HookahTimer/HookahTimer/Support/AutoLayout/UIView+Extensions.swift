// Copyright © 2021 Инновационные сервисы. All rights reserved.

import UIKit

/// Сторона view для прикрепления
public enum PinnedSide {
    case top
    case leading
    case trailing
    case bottom
}

public extension UIView {

    /// Подготовлен ли объект к использованию в Auto Layout
    var isPreparedForAutoLayout: Bool { !translatesAutoresizingMaskIntoConstraints }

    /// Подготовить объект к использованию в Auto Layout
    ///
    /// Устанавливает `translatesAutoresizingMaskIntoConstraints` в значение `false`
    @discardableResult
    func prepareForAutoLayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

}

public extension UIView {

    // MARK: - Pin to superview

    /// Прикрепить к границам `superview` с заданными отступами
    ///
    /// - Parameter edgeInsets: Отступы для сторон
    func pinToSuperviewEdges(edgeInsets: UIEdgeInsets) {
        guard let superview = superview else {
            return assertionFailure("Не обнаружена superview для \(description)")
        }
        checkAutoLayoutPreparing()

        leadingAnchor ~= superview.leadingAnchor + edgeInsets.left
        trailingAnchor ~= superview.trailingAnchor - edgeInsets.right
        topAnchor ~= superview.topAnchor + edgeInsets.top
        bottomAnchor ~= superview.bottomAnchor - edgeInsets.bottom
    }

    /// Прикрепить к границам `superview` с заданными отступами
    ///
    /// - Parameters:
    ///     - top: Отступ сверху
    ///     - left: Отступ слева
    ///     - bottom: Отступ снизу
    ///     - right: Отступ справа
    func pinToSuperviewEdges(
        top: CGFloat = 0,
        left: CGFloat = 0,
        bottom: CGFloat = 0,
        right: CGFloat = 0
    ) {
        pinToSuperviewEdges(edgeInsets: UIEdgeInsets(
            top: top,
            left: left,
            bottom: bottom,
            right: right
        ))
    }

    /// Прикрепить к границам superview с заданным общим отступом
    ///
    /// - Parameter offset: Отступ от superview
    func pinToSuperviewEdges(offset: CGFloat) {
        pinToSuperviewEdges(
            top: offset,
            left: offset,
            bottom: offset,
            right: offset
        )
    }

    /// Прикрепить к центру `superview`
    ///
    /// - Parameters:
    ///     - xOffset: Отступ от центра по оси X
    ///     - yOffset: Отступ от центра по оси Y
    func pinToSuperviewCenter(xOffset: CGFloat = 0, yOffset: CGFloat = 0) {
        guard let superview = superview else {
            return assertionFailure("Не обнаружена superview для \(description)")
        }
        checkAutoLayoutPreparing()

        centerXAnchor ~= superview.centerXAnchor + xOffset
        centerYAnchor ~= superview.centerYAnchor + yOffset
    }

    /// Прикрепить к границам `superview` за исключением одной из сторон
    ///
    /// - Parameter side: Сторона, которая не будет прикреплена
    func pinToSuperviewEdges(excluding side: PinnedSide) {
        switch side {
        case .top:
            self.pinToSuperview(.leading, .trailing, .bottom)
        case .leading:
            self.pinToSuperview(.top, .trailing, .bottom)
        case .trailing:
            self.pinToSuperview(.top, .leading, .bottom)
        case .bottom:
            self.pinToSuperview(.top, .leading, .trailing)
        }
    }

    /// Прикрепить границы к `superview`
    ///
    /// - Parameter sides: Массив сторон для прикрепления
    func pinToSuperview(_ sides: PinnedSide...) {
        guard let superview = superview, !sides.isEmpty else {
            return assertionFailure("Не обнаружена superview для \(description)")
        }
        checkAutoLayoutPreparing()

        sides.forEach { side in
            switch side {
            case .top:
                topAnchor ~= superview.topAnchor
            case .leading:
                leadingAnchor ~= superview.leadingAnchor
            case .trailing:
                trailingAnchor ~= superview.trailingAnchor
            case .bottom:
                bottomAnchor ~= superview.bottomAnchor
            }
        }
    }

    // MARK: - Adding subviews

    /// Добавить `subview` и прикрепить к своим границам с заданными отступами
    ///
    /// - Parameters:
    ///     - view: Добавляемая `view`
    ///     - edgeInsets: Отступы для сторон
    func addSubviewMatchingEdges(_ view: UIView, edgeInsets: UIEdgeInsets) {
        addSubview(view)
        view.pinToSuperviewEdges(edgeInsets: edgeInsets)
    }

    /// Добавить `subview` и прикрепить к своим границам с заданными отступами
    ///
    /// - Parameters:
    ///     - view: Добавляемая `view`
    ///     - top: Отступ сверху
    ///     - left: Отступ слева
    ///     - bottom: Отступ снизу
    ///     - right: Отступ справа
    func addSubviewMatchingEdges(
        _ view: UIView,
        top: CGFloat = 0,
        left: CGFloat = 0,
        bottom: CGFloat = 0,
        right: CGFloat = 0
    ) {
        addSubview(view)
        view.pinToSuperviewEdges(top: top, left: left, bottom: bottom, right: right)
    }

    /// Добавить `subview` и прикрепить к своим границам с общим отступом
    ///
    /// - Parameters:
    ///     - view: Добавляемая `view`
    ///     - offset: Отступы для сторон
    func addSubviewMatchingEdges(_ view: UIView, offset: CGFloat) {
        addSubview(view)
        view.pinToSuperviewEdges(offset: offset)
    }

    private func checkAutoLayoutPreparing() {
        if !self.isPreparedForAutoLayout {
            assertionFailure("Использование Autolayout со значением translatesAutoresizingMaskIntoConstraints == true")
            prepareForAutoLayout()
        }
    }
}

public extension UIView {

    // MARK: - Pin to another view

    /// Прикрепить к границам другого объекта
    ///
    /// - Parameters:
    ///     - constraintable: Объект для прикрепления
    ///     - edgeInsets: Отступы для границ
    func pin(to constraintable: Constraintable, edgeInsets: UIEdgeInsets = .zero) {
        checkAutoLayoutPreparing()

        topAnchor ~= constraintable.topAnchor + edgeInsets.top
        trailingAnchor ~= constraintable.trailingAnchor - edgeInsets.right
        leadingAnchor ~= constraintable.leadingAnchor + edgeInsets.left
        bottomAnchor ~= constraintable.bottomAnchor - edgeInsets.bottom
    }

    /// Прикрепить к некоторым границам другого объекта
    ///
    /// - Parameters:
    ///     - constraintable: Объект для прикрепления
    ///     - sides: Границы для прикрепления
    func pin(to constraintable: Constraintable, using sides: PinnedSide...) {
        checkAutoLayoutPreparing()

        sides.forEach { side in
            switch side {
            case .top:
                topAnchor ~= constraintable.topAnchor
            case .trailing:
                trailingAnchor ~= constraintable.trailingAnchor
            case .leading:
                leadingAnchor ~= constraintable.leadingAnchor
            case .bottom:
                bottomAnchor ~= constraintable.bottomAnchor
            }
        }
    }

    /// Прикрепить к границам другого объекта с заданными отступами
    ///
    /// - Parameters:
    ///     - constraintable: Объект для прикрепления
    ///     - top: Отступ сверху
    ///     - left: Отступ слева
    ///     - bottom: Отступ снизу
    ///     - right: Отступ справа
    func pin(
        to constraintable: Constraintable,
        top: CGFloat = 0,
        left: CGFloat = 0,
        bottom: CGFloat = 0,
        right: CGFloat = 0
    ) {
        pin(
            to: constraintable,
            edgeInsets: UIEdgeInsets(
                top: top,
                left: left,
                bottom: bottom,
                right: right
            )
        )
    }
}

public extension UILayoutGuide {

    // MARK: - Pin to another view

    /// Прикрепить к границам другого объекта
    ///
    /// - Parameters:
    ///     - constraintable: Объект для прикрепления
    ///     - edgeInsets: Отступы для границ
    func pin(to constraintable: Constraintable, edgeInsets: UIEdgeInsets = .zero) {
        topAnchor ~= constraintable.topAnchor + edgeInsets.top
        trailingAnchor ~= constraintable.trailingAnchor - edgeInsets.right
        leadingAnchor ~= constraintable.leadingAnchor + edgeInsets.left
        bottomAnchor ~= constraintable.bottomAnchor - edgeInsets.bottom
    }

    /// Прикрепить к некоторым границам другого объекта
    ///
    /// - Parameters:
    ///     - constraintable: Объект для прикрепления
    ///     - sides: Границы для прикрепления
    func pin(to constraintable: Constraintable, using sides: PinnedSide...) {
        sides.forEach { side in
            switch side {
            case .top:
                topAnchor ~= constraintable.topAnchor
            case .trailing:
                trailingAnchor ~= constraintable.trailingAnchor
            case .leading:
                leadingAnchor ~= constraintable.leadingAnchor
            case .bottom:
                bottomAnchor ~= constraintable.bottomAnchor
            }
        }
    }

    /// Прикрепить к границам другого объекта с заданными отступами
    ///
    /// - Parameters:
    ///     - constraintable: Объект для прикрепления
    ///     - top: Отступ сверху
    ///     - left: Отступ слева
    ///     - bottom: Отступ снизу
    ///     - right: Отступ справа
    func pin(
        to constraintable: Constraintable,
        top: CGFloat = 0,
        left: CGFloat = 0,
        bottom: CGFloat = 0,
        right: CGFloat = 0
    ) {
        pin(
            to: constraintable,
            edgeInsets: UIEdgeInsets(
                top: top,
                left: left,
                bottom: bottom,
                right: right
            )
        )
    }
}
