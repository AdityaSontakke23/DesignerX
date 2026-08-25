#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "armchair" asset catalog image resource.
static NSString * const ACImageNameArmchair AC_SWIFT_PRIVATE = @"armchair";

/// The "bath" asset catalog image resource.
static NSString * const ACImageNameBath AC_SWIFT_PRIVATE = @"bath";

/// The "bed" asset catalog image resource.
static NSString * const ACImageNameBed AC_SWIFT_PRIVATE = @"bed";

/// The "dishwasher" asset catalog image resource.
static NSString * const ACImageNameDishwasher AC_SWIFT_PRIVATE = @"dishwasher";

/// The "fireplace" asset catalog image resource.
static NSString * const ACImageNameFireplace AC_SWIFT_PRIVATE = @"fireplace";

/// The "machinery" asset catalog image resource.
static NSString * const ACImageNameMachinery AC_SWIFT_PRIVATE = @"machinery";

/// The "sink" asset catalog image resource.
static NSString * const ACImageNameSink AC_SWIFT_PRIVATE = @"sink";

/// The "sofa" asset catalog image resource.
static NSString * const ACImageNameSofa AC_SWIFT_PRIVATE = @"sofa";

/// The "steps" asset catalog image resource.
static NSString * const ACImageNameSteps AC_SWIFT_PRIVATE = @"steps";

/// The "stove" asset catalog image resource.
static NSString * const ACImageNameStove AC_SWIFT_PRIVATE = @"stove";

/// The "table" asset catalog image resource.
static NSString * const ACImageNameTable AC_SWIFT_PRIVATE = @"table";

/// The "toilet" asset catalog image resource.
static NSString * const ACImageNameToilet AC_SWIFT_PRIVATE = @"toilet";

/// The "tv-monitor" asset catalog image resource.
static NSString * const ACImageNameTvMonitor AC_SWIFT_PRIVATE = @"tv-monitor";

/// The "wardrobe" asset catalog image resource.
static NSString * const ACImageNameWardrobe AC_SWIFT_PRIVATE = @"wardrobe";

#undef AC_SWIFT_PRIVATE
