

import Foundation
import UIKit
import CoreData




//MARK: - Aliases

typealias JSONObject = AnyObject
typealias JSONDictionary = [String: JSONObject]
typealias JSONArray = [JSONDictionary]


//MARK: - Parsing JSON

func parsing (hackerBook json: JSONDictionary) throws -> () {
    
    
    //Para lo de arriba necesitamos un contexto por lo que es necesario acceder al appdelegate que es el que tiene la pila de coreData actualmente
    let miDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate  //El shared es un singleton
    
    let objectContext = miDelegate.persistentContainer.viewContext
    
    
    let bookFecthRequest: NSFetchRequest<Book> = Book.fetchRequest()
    
    var searchResultsBook: Array<Book> = []
    
    var managedObjectContext: NSManagedObjectContext?
    
    
    let tagFetchRequest: NSFetchRequest<Tag> = Tag.fetchRequest()
    
    var searchResultsTag: Array<Tag> = []
    
    let defaults = UserDefaults.standard
    

    
    guard let title = json["title"] as? String else{
        
        throw HackerBooksErrors.jsonParsingError
        
    }
    
    let predicado = NSPredicate(format: "title = %@", title)
    
    bookFecthRequest.predicate = predicado
    bookFecthRequest.fetchLimit = 1
    searchResultsBook = try objectContext.fetch(bookFecthRequest)
    
    if searchResultsBook.count  < 1 {
    
    
    let authors = json["authors"] as? String
    
    let authorsArray =  authors?.components(separatedBy: ",")

    
    var photoUrl: String = ""
    
    if (defaults.data(forKey: title) == nil){
    
    guard let imageUrlString = json["image_url"] as? String, let imageUrl = URL(string: imageUrlString), let dataImage = try? Data(contentsOf: imageUrl) else{
        
        throw HackerBooksErrors.imageJSONError
        
        }
        
        photoUrl = imageUrlString
        
        //Si todo va bien lo guardamos
        defaults.set(dataImage, forKey: title)
    }
        
    guard let imageData = defaults.data(forKey: title) else{
        
        throw HackerBooksErrors.imageSaveRecoverFailed
        
    }
        
    let image = UIImage(data: imageData)
    
    guard let pdfUrl = json["pdf_url"] as? String else {
        
        
        throw HackerBooksErrors.pdfJSONError
                
    }
    
    
    
    if let tags = json["tags"] as? String {
        
    
        let tagsArray = tags.components(separatedBy: ", ")
        
        let newBook = NSEntityDescription.insertNewObject(forEntityName: "Book", into: objectContext) as! Book
        let newPdf = NSEntityDescription.insertNewObject(forEntityName: "Pdf", into: objectContext) as! Pdf
        let newPhoto = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: objectContext) as! Photo
        
        
        newBook.title = title
        
        newPdf.urlPdf = pdfUrl
        
        let pdfData = NSData(contentsOf: NSURL(string: pdfUrl) as! URL)
        
        if (pdfData != nil){
        
         newPdf.pdfData = pdfData
        
        
        } else {
            
            newPdf.pdfData = NSData(contentsOf: NSURL(string: "http://greenteapress.com/compmod/thinkcomplexity.pdf") as! URL)
            
            
        }
        
         newBook.bookPdf = newPdf
        
        newPhoto.urlPhoto = photoUrl
        newPhoto.photoData = imageData as NSData?
        
        newBook.bookPhoto = newPhoto
        
        
        
        for tag in tagsArray{
            
            let predicadoTag = NSPredicate(format: "name = %@", tag)
            
            tagFetchRequest.predicate = predicadoTag
            tagFetchRequest.fetchLimit = 1
            searchResultsTag = try objectContext.fetch(tagFetchRequest)
            
            if searchResultsTag.count > 0 {
                let existTag :Tag = searchResultsTag[0]
                
                newBook.addToBookTag(existTag)
                
            } else {
            
            let newTag = NSEntityDescription.insertNewObject(forEntityName: "Tag", into: objectContext) as! Tag
            newTag.name = tag
            newBook.addToBookTag(newTag)
            
         }
            
        }
        
        for authorName in authorsArray!{
            
            let newAuthor = NSEntityDescription.insertNewObject(forEntityName: "Author", into: objectContext) as! Author
            newAuthor.name = authorName
            newBook.addToBookAuthor(newAuthor)
            
        }
        
        //newBook.addToBookAuthor(authorsSet)
        //newBook.addToBookTag(tagsSet)
        
        miDelegate.saveContext()
        
        }
        
    } else {
        
       throw HackerBooksErrors.jsonParsingError
        
    }
    
}

// Sobrecargamos en el caso de que tengamos un opcional en lugar de un JSONDictionary directamente

func parsing(hackerBook json: JSONDictionary?) throws -> () {
    
    
    if case .some(let jsonDict) = json{
        
        return try parsing(hackerBook: jsonDict)
        
    }else {
        
        throw HackerBooksErrors.jsonParsingError
        
    }
    
}

//MARK: - Loading local file

func loadFromLocalFile(fileName name: String, bundle: Bundle = Bundle.main) throws -> JSONArray {
    
    
    if let url = bundle.URLForResource(name), let data = try? Data(contentsOf: url),
        let maybeArray = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? JSONArray, let array = maybeArray{
        
        return array
        
    } else{
        
        throw HackerBooksErrors.jsonParsingError
    }
    
    
    
}

//MARK: - Loading save File

func loadFromSaveFile (file name: Data) throws -> JSONArray {
    
   if let maybeArray = try? JSONSerialization.jsonObject(with: name, options: JSONSerialization.ReadingOptions.mutableContainers) as? JSONArray, let array = maybeArray{
        
        return array
        
    } else{
        
        throw HackerBooksErrors.jsonParsingError
    }
    

    
    
}
















