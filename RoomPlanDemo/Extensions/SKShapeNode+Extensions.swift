//
//  SKShapeNode+Extensions.swift
//  DesignerX
//
//  Created by Aditya Sontakke on 15.08.2026.
//

import SpriteKit

extension SKShapeNode {
    static func create(from path: CGPath,
                       strokeColor: UIColor = DrawParameters.floorPlanSurfaceColor,
                       lineWidth: CGFloat = DrawParameters.surfaceWidth,
                       zPosition: CGFloat? = nil) -> SKShapeNode {
        let shapeNode = SKShapeNode(path: path)
        shapeNode.strokeColor = strokeColor
        shapeNode.lineWidth = lineWidth
        
        if let zPosition {
            shapeNode.zPosition = zPosition
        }
        return shapeNode
    }
}
