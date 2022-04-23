// Copyright © 2021 Инновационные сервисы. All rights reserved.

import UIKit

extension Collection where Element == NSLayoutConstraint {

    /// Активировать все констрейнты массива.
    func activate() {
        forEach { $0.activate() }
    }

    /// Деактивировать все констрейнты массива.
    func deactivate() {
        forEach { $0.deactivate() }
    }

}
