//
//  CGFloat+Extensions.swift
//  DesignerX
//
//  Created by Aditya Sontakke on 16.08.2026.
//

import Foundation

extension CGFloat {
    var radiansToDegrees: CGFloat {
        return self * 180 / .pi
    }
    
    var degreesToRadians: CGFloat {
        return self * .pi / 180
    }
}
