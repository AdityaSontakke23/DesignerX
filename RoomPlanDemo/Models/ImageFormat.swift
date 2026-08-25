//
//  ImageFormat.swift
//  DesignerX
//
//  Created by Aditya Sontakke on 14.08.2026.
//

import Foundation

enum ImageFormat: String, CaseIterable {
    case png
    case jpeg
    case pdf
    
    var descriptionFormat: String {
        switch self {
        case .png:
            "PNG"
        case .jpeg:
            "JPEG"
        case .pdf:
            "PDF"
        }
    }
}
