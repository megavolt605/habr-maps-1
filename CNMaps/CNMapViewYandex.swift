//
//  CNMapViewYandex.swift
//  CNMaps
//
//  Created by Igor Smirnov on 28/08/15.
//  Copyright © 2015 Complex Numbers. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

final class CNMapViewYandex: NSObject, CNMapView, YMKMapViewDelegate {
    
    private weak var _delegate: CNMapViewDelegate?
    weak var delegate: CNMapViewDelegate? {
        get {
            return _delegate
        }
        set {
            _delegate = newValue
        }
    }

    /* remove
    var annotations: [CNMapAnnotation] {
        var res = _mapView.annotations
        if let index = (res.indexOf() { ($0 as? YMKUserLocation) == self._mapView.userLocation }) {
            res.removeAtIndex(index)
        }
        return res as! [CNMapAnnotation]
    }
    
    var selectedAnnotation: CNMapAnnotation? {
        get {
            return _mapView.selectedAnnotation as? CNMapAnnotation
        }
        set {
            _mapView.selectedAnnotation = newValue as? YMKAnnotation
        }
    }*/
    
    private var _mapView: YMKMapView!
    var view: UIView {
        return _mapView
    }
    
    var scaleFactor: Double {
        return 1.0
    }
    
    var skipTimer = false
    
    func setRegion(region: CNMapCoordinateRect) {
        let mapRegion = YMKMapRegion(
            center: CLLocationCoordinate2DMake(
                (region.topLeft.latitude + region.bottomRight.latitude) / 2.0,
                (region.topLeft.longitude + region.bottomRight.longitude) / 2.0
            ),
            span: YMKMapRegionSizeMake(
                abs(region.topLeft.latitude - region.bottomRight.latitude) / 2.0,
                abs(region.topLeft.longitude - region.bottomRight.longitude) / 2.0
            )
        )
        self._mapView.setRegion(mapRegion, animated: false)
    }
    
    func setCenterCoordinate(center: CLLocationCoordinate2D) {
        _mapView.setCenterCoordinate(center, animated: false)
    }
    
    func setCenterCoordinate(center: CLLocationCoordinate2D, animated: Bool) {
        _mapView.setCenterCoordinate(center, animated: animated)
    }
    
    func setCenterCoordinate(center: CLLocationCoordinate2D, atZoomLevel zoom: UInt, animated: Bool) {
        _mapView.setCenterCoordinate(center, atZoomLevel: zoom, animated: false)
    }
    
    /* remove
    func addAnnotations(annotations: [CNMapAnnotation]) {
        _mapView.addAnnotations(annotations)
    }
    
    func removeAnnotations(annotations: [CNMapAnnotation]) {
        _mapView.removeAnnotations(annotations)
    }

    func createAnnotation(actionsInfo: [CNPlace], coordinate: CLLocationCoordinate2D) -> CNMapAnnotation {
    return RPMapAnnotationYandex(actionsInfo: actionsInfo, coordinate: coordinate)
    }
    */
    
    func convertMapViewPointToLL(point: CGPoint) -> CLLocationCoordinate2D {
        return _mapView.convertMapViewPointToLL(point)
    }
    
    func convertMapViewPointToMapPoint(point: CGPoint) -> CNMapPoint {
        let mapPoint = _mapView.convertMapViewPointToMapPoint(point)
        return CNMapPoint(x: mapPoint.x, y: mapPoint.y)
    }
    
    func convertMapPointToMapView(point: CNMapPoint) -> CGPoint {
        let mapPoint = YMKMapPoint(x: point.x, y: point.y)
        return _mapView.convertMapPointToMapView(mapPoint)
    }
    
    func mapRect(mapRect: CNMapCoordinateRect, containsMapCoordinate coordinate: CLLocationCoordinate2D) -> Bool {
        let mapViewRect = YMKMapRect(topLeft: mapRect.topLeft, bottomRight: mapRect.bottomRight)
        return YMKMapRectContainsMapCoordinate(mapViewRect, coordinate)
    }
    
    func zoomIn() {
        _mapView.zoomIn()
    }
    
    func zoomOut() {
        _mapView.zoomOut()
    }
    
    /* remove
    // YMKMapView delegate
    func mapView(mapView: YMKMapView!, viewForAnnotation annotation: YMKAnnotation!) -> YMKAnnotationView! {
        let reuseID = "RPMapAnnotationViewReuseID"
        let clusterAnnotation = annotation as! RPMapAnnotation
        let annotationView = RPMapPinViewYandex(annotation: annotation as! NSObject, reuseIdentifier: reuseID)
        
        annotationView.canShowCallout = true
        annotationView.pinView.count = clusterAnnotation.actionCount
        
        return annotationView!
    }
    
    func mapView(view: YMKMapView!, calloutViewForAnnotation annotation: YMKAnnotation!) -> YMKCalloutView! {
        let identifier = "pointCallout"
        let callout = RPMapCalloutViewYandex(reuseIdentifier: identifier)
        callout.callout = RPMapCallout(parentView: self)
        
        if let a = annotation as? RPMapAnnotation {
            a.calloutView = callout
        }
        return callout
    }
    
    func mapView(mapView: YMKMapView!, didAddAnnotationViews views: [AnyObject]!) {
        for view in views as! [UIView] {
            RPUI.addBounceAnnimationToView(view)
        }
    }
    
    func mapViewShouldFollowUserLocation(map: YMKMapView) -> Bool {
        return false
    }
    
    func mapView(mapView: YMKMapView!, regionDidChangeAnimated animated: Bool) {
        delegate?.mapView(self, regionDidChangeAnimated: animated)
    }
    
    func openInfoForAnnotation(annotation: RPMapAnnotation) {
        selectedAnnotation = annotation
        annotation.disableUserInteractions()
        delegate?.mapView(self, openInfoForAnnotation: annotation)
    }
    */
    required override init() {
        super.init()
        YMKConfiguration.sharedInstance().apiKey = "ax~2ep69HGOYpwkEWPUWVBh2DSMr2t62BNpOgDJIIzOIuewCi622lUG51y9apE4MHs8IjSHIaRbKJC9WDACSQdprVk~df~zDgEuwibTwKWU="
        _mapView = YMKMapView()
        _mapView.showTraffic = false
        _mapView.showsUserLocation = true
        _mapView.tracksUserLocation = false
        _mapView.delegate = self
    }
    
    
}
