//
//  DetailBookViewController.swift
//  HackerBooksSuperPro
//
//  Created by Juan Luis Garcia on 5/1/17.
//  Copyright © 2017 styleapps. All rights reserved.
//

import UIKit
import CoreData


class DetailBookViewController: UIViewController {
    
    var bookRecieved:Book!
    
    
    @IBOutlet weak var imgView: UIImageView!{
        
        didSet{
            
            self.imgView.image = UIImage(data: bookRecieved.bookPhoto?.photoData as! Data)
            
        }
        
    }
    
    
    @IBOutlet weak var titleLblView: UILabel!{
        
        didSet{
            
            self.titleLblView.text = bookRecieved.title
            
            
        }
        
        
    }
    
    @IBOutlet weak var authorsLblView: UILabel!{
        
        didSet{
            
            let authorSet  = bookRecieved.bookAuthor
            
            var stringAuthor : String = ""
            
            for author in authorSet! {
                
                stringAuthor += (author as! Author).name! + ","
                
                
            }
            
            
            self.authorsLblView.text = stringAuthor
            
            
        }
        
    }
    

    @IBOutlet weak var tagsLblView: UILabel! {
        
        didSet{
            
            let tagSet  = bookRecieved.bookTag
            
            var stringTag : String = ""
            
            for tag in tagSet! {
                
                stringTag += (tag as! Tag).name! + ","
                
               
            }
            
            if stringTag.contains("Favorites"){
                
                favSwitch.isOn = true
                
            } else {
                
                favSwitch.isOn = false
                
            }
            
            self.tagsLblView.text = stringTag
            
        }
        
    }
    
    
    @IBAction func readPdf(_ sender: Any) {
    }
    
    @IBOutlet weak var favSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        //Estados del Switch
        favSwitch.addTarget(self, action: #selector(stateChanged), for: UIControlEvents.valueChanged)
        

        let lastBookReadID = bookRecieved.objectID.uriRepresentation()
        
        let lastBookRead = NSKeyedArchiver.archivedData(withRootObject: lastBookReadID)
        
        
        UserDefaults.standard.set(lastBookRead, forKey: "lastBookRead")
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func stateChanged(_ switchState: UISwitch){
        
        //Mandamos notificacion cuando se marca o desmarca un elemento de favoritos
        //la recibimos en hackerBooksTableViewController
        
       // let nCenter = NotificationCenter.default
        
        
        
        let miDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let tagFetchRequest: NSFetchRequest<Tag> = Tag.fetchRequest()
        
        var searchResultsTag: Array<Tag> = []
        
        let objectContext = miDelegate.persistentContainer.viewContext
        
        let predicadoTag = NSPredicate(format: "name = %@", "Favorites")
        
        tagFetchRequest.predicate = predicadoTag
        tagFetchRequest.fetchLimit = 1
        
        do{
        searchResultsTag = try objectContext.fetch(tagFetchRequest)

            }catch (let e as NSError) {
            
            print("Error al realizar busqueda de tag. \(e)")
            
        }
        
        if switchState.isOn{
            
            
            if searchResultsTag.count > 0 {
                let existTag :Tag = searchResultsTag[0]
                
                bookRecieved.addToBookTag(existTag)
                
            } else {
                
                let newTag = NSEntityDescription.insertNewObject(forEntityName: "Tag", into: objectContext) as! Tag
                newTag.name = "Favorites"
                bookRecieved.addToBookTag(newTag)
                
            }
            
            
            miDelegate.saveContext()
            tagsLblView.text = tagsLblView.text! + "Favorites"
            
        } else {
            
            
            if searchResultsTag.count > 0 {
                let existTag :Tag = searchResultsTag[0]
                
                bookRecieved.removeFromBookTag(existTag)
                
                if (existTag.tagBook?.count)! < 1{
                    
                    objectContext.delete(existTag)
                    
                    miDelegate.saveContext()
                }
                
                
            }
            
            
            tagsLblView.text = tagsLblView.text?.replacingOccurrences(of: "Favorites", with: "")
            
            
        }
        
        
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "readPDF" {
            
    
            //De momento como ya lo tenemos todo lo pasamos
            
        
            let selectedPDF = bookRecieved.bookPdf
            
            let pdfDetail: PdfViewController = segue.destination as! PdfViewController
            
            pdfDetail.pdfRecieved = selectedPDF
            
            
            
        }
        
        if segue.identifier == "notesMapView" {

            let selectedBook = bookRecieved
            
            let mapViewNotes: MapViewController = segue.destination as! MapViewController
            
            
            mapViewNotes.bookRaceivedinMap = selectedBook
            
            
        }

        
        
        
    }
    

}











