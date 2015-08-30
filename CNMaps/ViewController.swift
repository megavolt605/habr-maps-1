//
//  ViewController.swift
//  CNMaps
//
//  Created by Igor Smirnov on 28/08/15.
//  Copyright © 2015 Complex Numbers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var mapProvider: CNMapProvider!
    var mapView: CNMapView!
    
    @IBOutlet weak var mapContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapProvider = .Apple
        createMapView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView?.view.frame = mapContainerView.bounds
    }

    @IBAction func mapProviderChanged(sender: UISegmentedControl) {
        mapProvider = CNMapProvider(rawValue: sender.selectedSegmentIndex)!
        createMapView()
    }
    
    func createMapView() {
        mapView?.view.removeFromSuperview()
        mapView = mapProvider.createView(self)
        mapContainerView.addSubview(mapView.view)
    }
}

