//
//  CNMapViewGoogle.swift
//  CNMaps
//
//  Created by Igor Smirnov on 29/08/15.
//  Copyright © 2015 Complex Numbers. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import GoogleMaps

final class CNMapViewGoogle: NSObject, CNMapView, GMSMapViewDelegate {
    
    var delegate: CNMapViewDelegate?
    
    /* remove
    private var markers: [CNMapMarkerGoogle] = []
    private weak var selectedMarker: CNMapMarkerGoogle? {
        willSet {
            if let m = selectedMarker {
                m.selected = false
            }
            if let m = newValue {
                m.selected = true
            } else {
                callout?.hide()
                callout = nil
            }
            _mapView.selectedMarker = newValue
        }
    }
    var annotations: [CNMapAnnotation] = []
    
    var selectedAnnotation: CNMapAnnotation? {
        get {
            return selectedMarker?.annotation
        }
        set {
            let marker = markers.lookup() { $0.annotation == newValue }
            if marker != _mapView.selectedMarker {
                _mapView.selectedMarker = nil
                callout?.hide(animated: false)
                _mapView.selectedMarker = marker
            }
        }
    }
    
    private var callout: CNMapCallout?
    */
    
    private var _mapView: GMSMapView!
    var view: UIView {
        return _mapView
    }
    
    var scaleFactor: Double {
        return 0.5
    }
    
    var skipTimer = false
    
    func setRegion(region: CNMapCoordinateRect) {
        let cameraUpdate = GMSCameraUpdate.fitBounds(GMSCoordinateBounds(coordinate: region.topLeft, coordinate: region.bottomRight))
        _mapView.animateWithCameraUpdate(cameraUpdate)
    }
    
    func setCenterCoordinate(center: CLLocationCoordinate2D) {
        let camera = GMSCameraPosition(target: center, zoom: _mapView.camera.zoom, bearing: 0, viewingAngle: 0)
        _mapView.animateToCameraPosition(camera)
    }
    
    func setCenterCoordinate(center: CLLocationCoordinate2D, animated: Bool) {
        let camera = GMSCameraPosition(target: center, zoom: _mapView.camera.zoom, bearing: 0, viewingAngle: 0)
        _mapView.animateToCameraPosition(camera)
    }
    
    func setCenterCoordinate(center: CLLocationCoordinate2D, atZoomLevel zoom: UInt, animated: Bool) {
        let camera = GMSCameraPosition(target: center, zoom: Float(zoom), bearing: 0, viewingAngle: 0)
        _mapView.animateToCameraPosition(camera)
    }
    
    /* remove
    func addAnnotations(annotations: [CNMapAnnotation]) {
        self.annotations += annotations
        for a in annotations {
            let marker = RPMapMarkerGoogle(position: a.internalCoordinate)
            marker.annotation = a
            marker.appearAnimation = kGMSMarkerAnimationPop
            marker.groundAnchor = CGPointMake(0.5, 0.5)
            marker.map = _mapView
            markers.append(marker)
        }
    }
    
    func removeAnnotations(annotations: [RPMapAnnotation]) {
        if annotations.count > 0 {
            self.annotations = self.annotations.filter() { !contains(annotations, $0) }
            for m in markers {
                if m.annotation == nil || contains(annotations, m.annotation) {
                    m.map = nil
                    m.annotation = nil
                    if selectedMarker == m {
                        selectedMarker = nil
                    }
                }
            }
            markers = markers.filter() { $0.map != nil }
        }
    }
    */
    
    func convertMapViewPointToLL(point: CGPoint) -> CLLocationCoordinate2D {
        return _mapView.projection.coordinateForPoint(point)
    }
    
    func convertMapViewPointToMapPoint(point: CGPoint) -> CNMapPoint {
        let mapPoint = MKMapPointForCoordinate(convertMapViewPointToLL(point))
        return CNMapPoint(x: Int64(mapPoint.x), y: Int64(mapPoint.y))
    }
    
    func convertMapPointToMapView(point: CNMapPoint) -> CGPoint {
        let mapPoint = MKCoordinateForMapPoint(MKMapPointMake(Double(point.x), Double(point.y)))
        return _mapView.projection.pointForCoordinate(mapPoint)
    }
    
    func mapRect(mapRect: CNMapCoordinateRect, containsMapCoordinate coordinate: CLLocationCoordinate2D) -> Bool {
        return (coordinate.latitude >= mapRect.topLeft.latitude) &&
            (coordinate.latitude <= mapRect.bottomRight.latitude) &&
            (coordinate.longitude >= mapRect.topLeft.longitude) &&
            (coordinate.longitude <= mapRect.bottomRight.longitude)
    }
    
    func zoomIn() {
        _mapView.animateToZoom(_mapView.camera.zoom * 1.1)
    }
    
    func zoomOut() {
        _mapView.animateToZoom(_mapView.camera.zoom / 1.1)
    }
    
    /* remove
    func createAnnotation(actionsInfo: [CNPlace], coordinate: CLLocationCoordinate2D) -> CNMapAnnotation {
        return RPMapAnnotationGoogle(actionsInfo: actionsInfo, coordinate: coordinate)
    }
    
    func deselectPin() {
        selectedMarker = nil
    }
    
    // GMSMapView delegate
    func mapView(mapView: GMSMapView!, markerInfoWindow marker: GMSMarker!) -> UIView! {
        let identifier = "pointCallout"
        callout = RPMapCallout(parentView: self)
        
        if let m = marker as? RPMapMarkerGoogle {
            callout?.showAtAnnotation(m.annotation, animated: true)
            //            callout?.enableUserInteraction()
            m.annotation.calloutView = callout?.infoView
        }
        
        return nil
    }
    
    func mapView(mapView: GMSMapView!, idleAtCameraPosition position: GMSCameraPosition!) {
        delegate?.mapView(self, regionDidChangeAnimated: true)
    }
    
    func mapView(mapView: GMSMapView!, didTapMarker marker: GMSMarker!) -> Bool {
        deselectPin()
        if let m = marker as? CNMapMarkerGoogle {
            selectedMarker = m
            return true
        }
        return false
    }
    
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        deselectPin()
    }
    
    func mapView(mapView: GMSMapView!, didTapInfoWindowOfMarker marker: GMSMarker!) {
    }
    
    func openInfoForAnnotation(annotation: CNMapAnnotation) {
        selectedAnnotation = annotation
        annotation.disableUserInteractions()
        delegate?.mapView(self, openInfoForAnnotation: annotation)
    }
    */
    required override init() {
        super.init()
        GMSServices.provideAPIKey("AIzaSyBN1W9X3bi4klljuFYL-8KryDL7dG4ydRk")
        _mapView = GMSMapView()
        _mapView.myLocationEnabled = true
        _mapView.settings.rotateGestures = false
        _mapView.settings.tiltGestures = false
        _mapView.delegate = self
    }
    
    
}
