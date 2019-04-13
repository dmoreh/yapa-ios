//
//  UIColor+Yapa.swift
//  Yapa
//
//  Created by Daniel Moreh on 4/13/19.
//  Copyright © 2019 Daniel Moreh. All rights reserved.
//

import UIKit

extension UIColor {
    class var lightOrange: UIColor {
        return UIColor.orange.withAlphaComponent(0.1)
    }

    class var mediumOrange: UIColor {
        return UIColor.init(red: 244.0 / 255.0, green: 198.0 / 255.0, blue: 152.0 / 255.0, alpha: 1)
    }

    class var orange: UIColor {
        return UIColor.init(red: 234.0 / 255.0, green: 110.0 / 255.0, blue: 55.0 / 255.0, alpha: 1)
    }
}
