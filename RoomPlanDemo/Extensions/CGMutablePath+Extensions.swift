//
//  CGMutablePath+Extensions.swift
//  DesignerX
//
//  Created by Aditya Sontakke on 16.08.2026.
//

import CoreGraphics

extension CGMutablePath {
    static func create(from pointA: CGPoint, to pointB: CGPoint) -> CGMutablePath {
        let path = CGMutablePath()
        path.move(to: pointA)
        path.addLine(to: pointB)
        return path
    }
}
