// Copyright © 2021 Инновационные сервисы. All rights reserved.

import UIKit

public extension NSLayoutConstraint {

    /// Установка свойства `isActive` в значение `true`
    @discardableResult
    func activate() -> Self {
        isActive = true
        return self
    }

    /// Установка свойства `isActive` в значение `false`
    @discardableResult
    func deactivate() -> Self {
        isActive = false
        return self
    }

    /// Установка приоритета для constraint
    ///
    /// - Parameter priority: Приоритет
    /// - Returns: Обновленный констрейнт
    @discardableResult
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
