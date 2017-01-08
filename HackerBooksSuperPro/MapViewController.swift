//
//  MapViewController.swift
//  HackerBooksSuperPro
//
//  Created by Juan Luis Garcia on 6/1/17.
//  Copyright © 2017 styleapps. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController, MKMapViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var mapViewObject: MKMapView!
    
    @IBOutlet weak var selectView: UISegmentedControl!
    
    var bookRaceivedinMap: Book!
    
    
    let initialLocation = CLLocation(latitude: 40.532654, longitude: -3.647416)//ES KeepCoding en Madrid ejejjejeje
    
    var imagePicker: UIImagePickerController!
    var newAnnotationCreated: Annotations!
    var annotation:MKPointAnnotation!
    
    let miDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapViewObject.delegate = self

        // Do any additional setup after loading the view.
        
        mapViewObject.showsUserLocation = true
        
        
        centerMapOnLocation(location: initialLocation)
        
    
        let alertControllerInitial = UIAlertController(title: "A todos los Padawans", message: "Lo normal seria que el proceso, gracias a la fuerza, seleccionara la ubicacion del usuario y comenzara el proceso de la anotacion, como no es posible en el simulador, pulsa un rato en la ubicacioin que desees y veras como la anotacion tu creas", preferredStyle: UIAlertControllerStyle.alert)
        
        
         alertControllerInitial.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
         self.present(alertControllerInitial, animated: true, completion: nil)
        
        
        let longPressed = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotation))
        
        longPressed.minimumPressDuration = 0.5
        self.mapViewObject.addGestureRecognizer(longPressed)
        
        let annotationSet = bookRaceivedinMap.bookAnnotations
        
        if (annotationSet?.count)! > 0 {
            
            for annotation in annotationSet! {
                
                annotationExist(annotation: annotation as! Annotations)
                
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectViewAction(_ sender: Any) {
        
        switch selectView.selectedSegmentIndex {
        case 0:
            mapViewObject.mapType = .standard
        case 1:
            mapViewObject.mapType = .satellite
        case 2:
            mapViewObject.mapType = .hybrid
        default:
            break
        }
        
        
    }
    
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapViewObject.setRegion(coordinateRegion, animated: true)
    }
    
    
    func annotationExist(annotation: Annotations){
        
        let coord:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: annotation.latitude, longitude: annotation.longitude)
        
        
        let existAnnotation = MKPointAnnotation()
        existAnnotation.coordinate = coord
        
        existAnnotation.title = annotation.annotationString
        
        self.mapViewObject.addAnnotation(existAnnotation)
        
    }
    
    
    func addAnnotation(sender:UILongPressGestureRecognizer){
        
        if sender.state == UIGestureRecognizerState.began {
            let point = sender.location(in: self.mapViewObject)
            let coord:CLLocationCoordinate2D = mapViewObject.convert(point, toCoordinateFrom: self.mapViewObject)
          
            let objectContext = miDelegate.persistentContainer.viewContext
            let newAnnotation = NSEntityDescription.insertNewObject(forEntityName: "Annotations", into: objectContext) as! Annotations
            
            
            annotation = MKPointAnnotation()
        
            annotation.coordinate = coord
            
              var textField: UITextField!
            
            let alertController = UIAlertController(title: "Introduce tu anotacion", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addTextField(configurationHandler: { (textFieldAnnotation) in
                
                textFieldAnnotation.placeholder = "Añade lo que quieras"
                textField = textFieldAnnotation
                
            
            })
           // alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            
            
            let alertController2 = UIAlertController(title: "Imagen para la anotacion", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController2.addAction(UIAlertAction(title: "Image", style: UIAlertActionStyle.default, handler: { (alertAction) in
                
                if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    return
                }
                
                self.imagePicker =  UIImagePickerController()
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .photoLibrary
                
                self.present(self.imagePicker, animated: true, completion: nil)
                
                
            }))

            
            
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (alertAAction) in
              
                self.annotation.title = textField.text
                
                newAnnotation.annotationString = self.annotation.title
                newAnnotation.latitude = coord.latitude
                newAnnotation.longitude = coord.longitude
                
                self.bookRaceivedinMap.addToBookAnnotations(newAnnotation)
                self.newAnnotationCreated = newAnnotation
          
                
                self.present(alertController2, animated: true, completion: nil)
   
            }))
            
            
            
            self.present(alertController, animated: true, completion: nil)
           
            
            
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = true
        }else{
            annotationView?.annotation = annotation
        }
        
        //Si no tiene foto usamos otra
        var imageTest: UIImage = UIImage(named: "chibiVader.jpg")!
        
        let annotationsBook = bookRaceivedinMap.bookAnnotations
        
        for annotations in annotationsBook! {
            
            let note = annotations as! Annotations
            
            if(annotation.coordinate.latitude == note.latitude && annotation.coordinate.longitude == note.longitude){
                
                if note.annotationPhoto != nil {
                    
                    imageTest = UIImage(data: note.annotationPhoto as! Data)!
                    
                }
            }
            
            
        }
        
        
        
        
        annotationView?.detailCalloutAccessoryView = UIImageView(image: resizeImage(image: imageTest, newWidth: 200))
    
        return annotationView
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        
        //MODIFICA EL FORMATO DE LA IMAGEN, PARA ADAPTAR EL OBJETO UIIMAGEVIEW AL TAMAÑO DE LA FOTO, Y NO LA MUESTRE DEFORMADA
       
        let image: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        self.mapViewObject.addAnnotation(annotation)
        
        newAnnotationCreated.annotationPhoto = UIImagePNGRepresentation(image) as NSData?
        
        miDelegate.saveContext()
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        
        
        image.draw(in: CGRect(x: 0, y: 0,width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
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
