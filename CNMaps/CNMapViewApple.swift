//
//  CNMapViewApple.swift
//  CNMaps
//
//  Created by Igor Smirnov on 28/08/15.
//  Copyright © 2015 Complex Numbers. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension MKMapView {
    
    func setCenterCoordinate(centerCoordinate: CLLocationCoordinate2D, zoomLevel: UInt, animated: Bool) {
        let span = MKCoordinateSpanMake(0.0, 360.0 / pow(2.0, Double(zoomLevel)) * Double(frame.size.width) / 256.0)
        setRegion(MKCoordinateRegionMake(centerCoordinate, span), animated: animated)
    }
    
}

final class CNMapViewApple: NSObject, CNMapView, MKMapViewDelegate {

    var delegate: CNMapViewDelegate?

    private var _mapView: MKMapView!
    var view: UIView {
        return _mapView
    }

    private var _zoomLevel: UInt = 16 {
        didSet {
            if _mapView != nil {
                _mapView.setCenterCoordinate(_mapView.centerCoordinate, zoomLevel: _zoomLevel, animated: true)
            }
        }
    }

    func setRegion(region: CNMapCoordinateRect) {
        let mapRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2DMake(
                (region.topLeft.latitude + region.bottomRight.latitude) / 2.0,
                (region.topLeft.longitude + region.bottomRight.longitude) / 2.0
            ),
            span: MKCoordinateSpanMake(
                abs(region.topLeft.latitude - region.bottomRight.latitude) / 2.0,
                abs(region.topLeft.longitude - region.bottomRight.longitude) / 2.0
            )
        )
        _mapView.setRegion(mapRegion, animated: false)
    }
    
    func setCenterCoordinate(center: CLLocationCoordinate2D) {
        _mapView.setCenterCoordinate(center, animated: false)
    }
    
    func setCenterCoordinate(center: CLLocationCoordinate2D, animated: Bool) {
        _mapView.setCenterCoordinate(center, animated: animated)
    }
    
    func setCenterCoordinate(center: CLLocationCoordinate2D, atZoomLevel zoom: UInt, animated: Bool) {
        _mapView.setCenterCoordinate(center, zoomLevel: zoom, animated: false)
    }
    
    func convertMapViewPointToLL(point: CGPoint) -> CLLocationCoordinate2D {
        return _mapView.convertPoint(point, toCoordinateFromView: nil)
    }
    
    func convertMapViewPointToMapPoint(point: CGPoint) -> CNMapPoint {
        let mapPoint = MKMapPointForCoordinate(convertMapViewPointToLL(point))
        return CNMapPoint(x: Int64(mapPoint.x), y: Int64(mapPoint.y))
    }
    
    func convertMapPointToMapView(point: CNMapPoint) -> CGPoint {
        let mapPoint = MKMapPointMake(Double(point.x), Double(point.y))
        return _mapView.convertCoordinate(MKCoordinateForMapPoint(mapPoint), toPointToView: nil)
    }
    
    func mapRect(mapRect: CNMapCoordinateRect, containsMapCoordinate coordinate: CLLocationCoordinate2D) -> Bool {
        let mapPoint = MKMapPointForCoordinate(coordinate)
        let a = MKMapPointForCoordinate(mapRect.topLeft)
        let b = MKMapPointForCoordinate(mapRect.bottomRight)
        let mapRect = MKMapRectMake(min(a.x, b.x), min(a.y, b.y), max(a.x, b.x), max(a.y, b.y))
        return MKMapRectContainsPoint(mapRect, mapPoint)
    }
    
    func zoomIn() {
        _zoomLevel += 1
    }
    
    func zoomOut() {
        if _zoomLevel > 2 {
            _zoomLevel -= 1
        }
        
    }
    
    required override init() {
        super.init()
        _mapView = MKMapView()
        _mapView.rotateEnabled = false
        _mapView.pitchEnabled = false
        _mapView.showsUserLocation = true
        _mapView.userTrackingMode = .FollowWithHeading
        _mapView.delegate = self
    }

}

