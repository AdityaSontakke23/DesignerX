import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ColorResource {

}

// MARK: - Image Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ImageResource {

    /// The "armchair" asset catalog image resource.
    static let armchair = DeveloperToolsSupport.ImageResource(name: "armchair", bundle: resourceBundle)

    /// The "bath" asset catalog image resource.
    static let bath = DeveloperToolsSupport.ImageResource(name: "bath", bundle: resourceBundle)

    /// The "bed" asset catalog image resource.
    static let bed = DeveloperToolsSupport.ImageResource(name: "bed", bundle: resourceBundle)

    /// The "dishwasher" asset catalog image resource.
    static let dishwasher = DeveloperToolsSupport.ImageResource(name: "dishwasher", bundle: resourceBundle)

    /// The "fireplace" asset catalog image resource.
    static let fireplace = DeveloperToolsSupport.ImageResource(name: "fireplace", bundle: resourceBundle)

    /// The "machinery" asset catalog image resource.
    static let machinery = DeveloperToolsSupport.ImageResource(name: "machinery", bundle: resourceBundle)

    /// The "sink" asset catalog image resource.
    static let sink = DeveloperToolsSupport.ImageResource(name: "sink", bundle: resourceBundle)

    /// The "sofa" asset catalog image resource.
    static let sofa = DeveloperToolsSupport.ImageResource(name: "sofa", bundle: resourceBundle)

    /// The "steps" asset catalog image resource.
    static let steps = DeveloperToolsSupport.ImageResource(name: "steps", bundle: resourceBundle)

    /// The "stove" asset catalog image resource.
    static let stove = DeveloperToolsSupport.ImageResource(name: "stove", bundle: resourceBundle)

    /// The "table" asset catalog image resource.
    static let table = DeveloperToolsSupport.ImageResource(name: "table", bundle: resourceBundle)

    /// The "toilet" asset catalog image resource.
    static let toilet = DeveloperToolsSupport.ImageResource(name: "toilet", bundle: resourceBundle)

    /// The "tv-monitor" asset catalog image resource.
    static let tvMonitor = DeveloperToolsSupport.ImageResource(name: "tv-monitor", bundle: resourceBundle)

    /// The "wardrobe" asset catalog image resource.
    static let wardrobe = DeveloperToolsSupport.ImageResource(name: "wardrobe", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "armchair" asset catalog image.
    static var armchair: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .armchair)
#else
        .init()
#endif
    }

    /// The "bath" asset catalog image.
    static var bath: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bath)
#else
        .init()
#endif
    }

    /// The "bed" asset catalog image.
    static var bed: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bed)
#else
        .init()
#endif
    }

    /// The "dishwasher" asset catalog image.
    static var dishwasher: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .dishwasher)
#else
        .init()
#endif
    }

    /// The "fireplace" asset catalog image.
    static var fireplace: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .fireplace)
#else
        .init()
#endif
    }

    /// The "machinery" asset catalog image.
    static var machinery: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .machinery)
#else
        .init()
#endif
    }

    /// The "sink" asset catalog image.
    static var sink: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .sink)
#else
        .init()
#endif
    }

    /// The "sofa" asset catalog image.
    static var sofa: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .sofa)
#else
        .init()
#endif
    }

    /// The "steps" asset catalog image.
    static var steps: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .steps)
#else
        .init()
#endif
    }

    /// The "stove" asset catalog image.
    static var stove: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .stove)
#else
        .init()
#endif
    }

    /// The "table" asset catalog image.
    static var table: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .table)
#else
        .init()
#endif
    }

    /// The "toilet" asset catalog image.
    static var toilet: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .toilet)
#else
        .init()
#endif
    }

    /// The "tv-monitor" asset catalog image.
    static var tvMonitor: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .tvMonitor)
#else
        .init()
#endif
    }

    /// The "wardrobe" asset catalog image.
    static var wardrobe: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .wardrobe)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "armchair" asset catalog image.
    static var armchair: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .armchair)
#else
        .init()
#endif
    }

    /// The "bath" asset catalog image.
    static var bath: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bath)
#else
        .init()
#endif
    }

    /// The "bed" asset catalog image.
    static var bed: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bed)
#else
        .init()
#endif
    }

    /// The "dishwasher" asset catalog image.
    static var dishwasher: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .dishwasher)
#else
        .init()
#endif
    }

    /// The "fireplace" asset catalog image.
    static var fireplace: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .fireplace)
#else
        .init()
#endif
    }

    /// The "machinery" asset catalog image.
    static var machinery: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .machinery)
#else
        .init()
#endif
    }

    /// The "sink" asset catalog image.
    static var sink: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .sink)
#else
        .init()
#endif
    }

    /// The "sofa" asset catalog image.
    static var sofa: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .sofa)
#else
        .init()
#endif
    }

    /// The "steps" asset catalog image.
    static var steps: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .steps)
#else
        .init()
#endif
    }

    /// The "stove" asset catalog image.
    static var stove: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .stove)
#else
        .init()
#endif
    }

    /// The "table" asset catalog image.
    static var table: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .table)
#else
        .init()
#endif
    }

    /// The "toilet" asset catalog image.
    static var toilet: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .toilet)
#else
        .init()
#endif
    }

    /// The "tv-monitor" asset catalog image.
    static var tvMonitor: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .tvMonitor)
#else
        .init()
#endif
    }

    /// The "wardrobe" asset catalog image.
    static var wardrobe: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .wardrobe)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ColorResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ImageResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

