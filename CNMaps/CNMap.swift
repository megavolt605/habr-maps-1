//
//  CNMap.swift
//  CNMaps
//
//  Created by Igor Smirnov on 28/08/15.
//  Copyright © 2015 Complex Numbers. All rights reserved.
//

import UIKit

enum CNMapProvider: Int {
    case Apple, Yandex, Google//, GIS, OSM

    // create new view with provider's map
    func createView(ownerViewController: UIViewController) -> CNMapView {
        switch self {
            case .Yandex: return CNMapViewYandex()
            case .Google: return CNMapViewGoogle()
            case .Apple: return CNMapViewApple()
        }
    }
}

