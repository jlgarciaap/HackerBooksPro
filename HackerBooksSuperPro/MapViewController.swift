//
//  MapViewController.swift
//  HackerBooksSuperPro
//
//  Created by Juan Luis Garcia on 6/1/17.
//  Copyright © 2017 styleapps. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var selectView: UISegmentedControl!
    
    
    let initialLocation = CLLocation(latitude: 40.532654, longitude: -3.647416)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self

        // Do any additional setup after loading the view.
        
        mapView.showsUserLocation = true
        
        
        centerMapOnLocation(location: initialLocation)
        
        
        let longPressed = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotation))
        
        longPressed.minimumPressDuration = 0.5
        self.mapView.addGestureRecognizer(longPressed)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectViewAction(_ sender: Any) {
        
        switch selectView.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            break
        }
        
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        <#code#>
    }
    
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addAnnotation(sender:UILongPressGestureRecognizer){
        
        if sender.state == UIGestureRecognizerState.began {
            let point = sender.location(in: self.mapView)
            let coord:CLLocationCoordinate2D = mapView.convert(point, toCoordinateFrom: self.mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coord
            
              var textField: UITextField!
            
            let alertController = UIAlertController(title: "Introduce tu anotacion", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addTextField(configurationHandler: { (textFieldAnnotation) in
                
                textFieldAnnotation.placeholder = "Añade lo que quieras"
                textField = textFieldAnnotation
                
            
            })
           // alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (alertAAction) in
              
                annotation.title = textField.text
                annotation.subtitle = textField.text
                //self.mapView.addAnnotation(annotation)

                
                http://sweettutos.com/2016/01/21/swift-mapkit-tutorial-series-how-to-customize-the-map-annotations-callout-request-a-transit-eta-and-launch-the-transit-directions-to-your-destination/
                
                mapView.set
                
                var annotationView: MKAnnotationView! = ""
                
                annotationView.image = UIImage(named: "chibiVader.jpg")
                
                annotationView.annotation = annotation
                
                
                self.mapView.addAnnotation(annotationView as! MKAnnotation)
                
            }))
            
            
            
            self.present(alertController, animated: true, completion: nil)

            
                    }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
