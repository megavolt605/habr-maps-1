//
//  CNMapTools.swift
//  CNMaps
//
//  Created by Igor Smirnov on 28/08/15.
//  Copyright © 2015 Complex Numbers. All rights reserved.
//

import Foundation
import CoreLocation

struct CNMapPoint {
    var x: Int64
    var y: Int64
}

struct CNMapCoordinateRect {
    
    var topLeft: CLLocationCoordinate2D
    var bottomRight: CLLocationCoordinate2D
    
    func containsLocation(location: CLLocationCoordinate2D) -> Bool {
        let containsX = topLeft.latitude <= location.latitude && location.latitude <= bottomRight.latitude
        let containsY = topLeft.longitude <= location.longitude && location.longitude <= bottomRight.longitude
        
        return containsX && containsY
    }
    
    func intersectsCoordinateRect(b2: CNMapCoordinateRect) -> Bool {
        return topLeft.latitude <= b2.bottomRight.latitude && bottomRight.latitude >= b2.topLeft.latitude &&
            topLeft.longitude <= b2.bottomRight.longitude && bottomRight.longitude >= b2.topLeft.longitude
    }
    
    var center: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(
            (bottomRight.latitude + topLeft.latitude) / 2.0,
            (bottomRight.longitude + topLeft.longitude) / 2.0
        )
    }
    
    var minX: Double {
        return min(topLeft.latitude, bottomRight.latitude)
    }
    
    var maxX: Double {
        return max(topLeft.latitude, bottomRight.latitude)
    }
    
    var minY: Double {
        return min(topLeft.longitude, bottomRight.longitude)
    }
    
    var maxY: Double {
        return max(topLeft.longitude, bottomRight.longitude)
    }
    
    init(x0: Double, y0: Double, xf: Double, yf: Double) {
        self.topLeft = CLLocationCoordinate2DMake(x0, y0)
        self.bottomRight = CLLocationCoordinate2DMake(xf, yf)
    }
    
    init(topLeft: CLLocationCoordinate2D, bottomRight: CLLocationCoordinate2D) {
        self.topLeft = topLeft
        self.bottomRight = bottomRight
    }
    
}

