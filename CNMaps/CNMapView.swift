//
//  CNMapView.swift
//  CNMaps
//
//  Created by Igor Smirnov on 28/08/15.
//  Copyright © 2015 Complex Numbers. All rights reserved.
//

import UIKit
import CoreLocation

protocol CNMapViewDelegate: class  {
    
    var mapView: CNMapView { get }
    
    func mapView(mapView: CNMapView, regionDidChangeAnimated animated: Bool)
    func setCenterCoordinate(coordinate: CLLocationCoordinate2D)
    
    // to-do func mapView(mapView: CNMapView, openInfoForAnnotation annotation: CNMapAnnotation)
    
}

protocol CNMapView {
    
    weak var delegate: CNMapViewDelegate? { get set }
    
    // to-do var annotations: [CNMapAnnotation] { get }
    // to-do var selectedAnnotation: CNMapAnnotation? { get set }
    
    var view: UIView { get }
    
    // to-do var scaleFactor: Double { get }
    
    func setRegion(region: CNMapCoordinateRect)
    func setCenterCoordinate(center: CLLocationCoordinate2D)
    func setCenterCoordinate(center: CLLocationCoordinate2D, animated: Bool)
    func setCenterCoordinate(center: CLLocationCoordinate2D, atZoomLevel zoom: UInt, animated: Bool)
    
    // to-do func addAnnotations(annotations: [CNMapAnnotation])
    // to-do func removeAnnotations(annotations: [CNMapAnnotation])
    
    func convertMapViewPointToLL(point: CGPoint) -> CLLocationCoordinate2D
    func convertMapViewPointToMapPoint(point: CGPoint) -> CNMapPoint
    func convertMapPointToMapView(point: CNMapPoint) -> CGPoint
    
    func mapRect(mapRect: CNMapCoordinateRect, containsMapCoordinate coordinate: CLLocationCoordinate2D) -> Bool
    
    // to-do func createAnnotation(locationsInfo: [CNPlace], coordinate: CLLocationCoordinate2D) -> CNMapAnnotation
    
    // to-do func openInfoForAnnotation(annotation: CNMapAnnotation)
    
    func zoomIn()
    func zoomOut()
    
    init()
    
}
