//
//  CoreDataTableViewController.swift
//  HackerBooksSuperPro
//
//  Created by Juan Luis Garcia on 4/1/17.
//  Copyright © 2017 styleapps. All rights reserved.
//

import UIKit
import CoreData

class CoreDataTableViewController: UITableViewController, UISearchBarDelegate {
    
    let fecthRequest: NSFetchRequest<Tag> = Tag.fetchRequest()

    var searchResults: Array<Tag> = []
    
    let fecthRequestSearch: NSFetchRequest<Book> = Book.fetchRequest()
    
    var searchResultsInSearch: Array<Book> = []

    var managedObjectContext: NSManagedObjectContext?
    
    @IBOutlet weak var searchBarToolbar: UISearchBar!
   
    @IBOutlet weak var lastReadButton: UIBarButtonItem!
        
    
    
     var searchActive : Bool = false
    
    func getActualContext() -> NSManagedObjectContext {//Con esta funcion obtenemos el contexto
        
        //Para lo de arriba necesitamos un contexto por lo que es necesario acceder al appdelegate que es el que tiene la pila de coreData actualmente
        let miDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate  //El shared es un singleton
        
        return miDelegate.persistentContainer.viewContext
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        searchBarToolbar.delegate = self

        managedObjectContext = getActualContext()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if UserDefaults.standard.value(forKey: "lastBookRead") == nil {
            lastReadButton.isEnabled = false
            
        } else {
            
            
            lastReadButton.isEnabled = true
            
        }
        
        
        do {
          
            
            fecthRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            
            searchResults =  try getActualContext().fetch(fecthRequest)
            tableView.reloadData()
            
        } catch let error as NSError {
            print("El error es: \(error)")
        }
        
        
        
    }

    
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        //Poner todo con tag para la secciones
        
        if (searchActive == false ){
            if (searchResults.count > 0)
            {
                
                return searchResults.count
                
            }
        }
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if (searchActive == false ){
            
            if searchResults.count > 0 {
                
                return (searchResults[section].tagBook?.count)!
                
            } else {
                
                return 0
                
            }
        } else {
            
            if searchResultsInSearch.count > 0 {
                
                return searchResultsInSearch.count
                
            } else {
                
                return 0
                
            }
        }
    }

    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        
        if (searchActive == false ){
            
            return 40.0
        }
        
        return 0
        
    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if  searchActive == false {
            
            if searchResults.count > 0 {
                
                return searchResults[section].name
                
            } else {
                
                return ""
                
            }
        } else{
            
                return ""
   
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header : UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        header.contentView.backgroundColor = UIColor.blue
        header.textLabel?.textColor = UIColor.white
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        
        var dataImage: NSData!
        
        
        if  searchActive == false {
            
            if (searchResults.count > 0){
                
                let bookSet = searchResults[indexPath.section].tagBook
                
                let bookArray = bookSet?.allObjects as! Array<Book>
                
                let title = bookArray[indexPath.row].title
            
            
                let bookPhoto:Photo = bookArray[indexPath.row].bookPhoto!
                
                let authorSet  = bookArray[indexPath.row].bookAuthor
                
                var stringAuthor : String = ""
                
                for author in authorSet! {
                    
                    stringAuthor += (author as! Author).name! + ","
                    
                    
                }
                
                var image: UIImage!
                
                image = UIImage(imageLiteralResourceName: "chibiVader.jpg")
                
                
                cell.imgView.image = image
                
                if bookPhoto.photoData != nil {
                    
                    image = UIImage(data: bookPhoto.photoData as! Data)!
                    
                    cell.imgView.image = image
                    
                } else {
                    
                    
                    DispatchQueue.global(qos:.default).async {
                        
                        do{
                            
                            dataImage = try obtainDataWithUrl(Url:NSURL(string:bookPhoto.urlPhoto!)!)
                            
                            
                            image = UIImage(data: dataImage as Data)!
                            
                            bookPhoto.photoData = dataImage
                            
                            try self.getActualContext().save()
                            
                            DispatchQueue.main.async {
                                
                                cell.imgView.image = image
                            
                            }
                            
                        }catch(let error as NSError){
                            
                            print("UPss Error \(error)")
                            
                        }
                        
                    }
                    
                }
                
                
                cell.titleLabelView?.text = title
                
                cell.authorsLabelView?.text = stringAuthor
                
            }
        }else {
            
            if (searchResultsInSearch.count > 0){
                
                
                let bookArray = searchResultsInSearch
                
                let title = bookArray[indexPath.row].title

                
                let bookPhoto:Photo = bookArray[indexPath.row].bookPhoto!
                
                var image: UIImage!
                
                image = UIImage(imageLiteralResourceName: "chibiVader.jpg")
                
                  cell.imgView.image = image
                
                let authorSet  = bookArray[indexPath.row].bookAuthor
                
                var stringAuthor : String = ""
                
                for author in authorSet! {
                    
                    stringAuthor += (author as! Author).name! + ","
                    
                    
                }
                
                if bookPhoto.photoData != nil {
                    
                    image = UIImage(data: bookPhoto.photoData as! Data)!
                    
                    cell.imgView.image = image
                    
                } else {
                    
                    
                    DispatchQueue.global(qos:.default).async {
                        
                        do{
                            
                            dataImage = try obtainDataWithUrl(Url:NSURL(string:bookPhoto.urlPhoto!)!)
                            
                            
                            image = UIImage(data: dataImage as Data)!
                            
                            bookPhoto.photoData = dataImage
                            
                            try self.getActualContext().save()
                            
                            DispatchQueue.main.async {
                                
                                
                                
                                cell.imgView.image = image
                                
                                
                                
                            }
                            
                            
                            
                        }catch(let error as NSError){
                            
                            print("UPss Error \(error)")
                            
                        }
                        
                    }
                    
                }

                
                
                cell.titleLabelView?.text = title
                
                cell.authorsLabelView?.text = stringAuthor
                
                
            }
            
            
        }
        
        return cell
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.characters.count > 2 {
            
            searchActive = true;
            
            fecthRequestSearch.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            
            let predicateInSearchBook = NSPredicate(format: "title CONTAINS[cd] %@", searchText, searchText)
            let predicateInSearchTag = NSPredicate(format: "ANY bookTag.name CONTAINS[cd] %@", searchText)
            let predicateInSearchAuthor = NSPredicate(format: "ANY bookAuthor.name CONTAINS[cd] %@", searchText)

            //title CONTAINS[cd] %@ OR
            let finalPreficate = NSCompoundPredicate.init(orPredicateWithSubpredicates: [predicateInSearchBook,predicateInSearchTag,predicateInSearchAuthor])
            
            
            fecthRequestSearch.predicate = finalPreficate
            
            do {
            
            searchResultsInSearch =  try getActualContext().fetch(fecthRequestSearch)
            
            }catch (let e as NSError){
                
                print("Ups error: \(e)")
                
            }
            
        } else {
            
            searchActive = false;
            
        }
        
        
        self.tableView.reloadData()
        
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
           let selectedBook: Book!
        
        if segue.identifier == "showBook" {
            
            var indexpath:IndexPath = self.tableView.indexPathForSelectedRow!
            
            if searchActive == false {
                
                let bookSet = searchResults[indexpath.section].tagBook
                
                let bookArray = bookSet?.allObjects as! Array<Book>
                
                selectedBook = bookArray[indexpath.row]
                
            } else {
                
                let bookArray = searchResultsInSearch
                
                selectedBook = bookArray[indexpath.row]

                
            }
            
            
            let bookDetail: DetailBookViewController = segue.destination as! DetailBookViewController
            
            bookDetail.bookRecieved = selectedBook
            
            
            
        }
        
        
        if segue.identifier == "showLastRead" && UserDefaults.standard.value(forKey: "lastBookRead") != nil {
 
            
            let bookLastRead: DetailBookViewController = segue.destination as! DetailBookViewController
            let dataBook: NSData = UserDefaults.standard.value(forKey: "lastBookRead") as! NSData
            
            let cosas = NSKeyedUnarchiver.unarchiveObject(with: dataBook as Data)
            
           let varios = getActualContext().persistentStoreCoordinator?.managedObjectID(forURIRepresentation: cosas as! URL)
            
            let bookLast: Book = getActualContext().object(with: varios!) as! Book
            
            
            bookLastRead.bookRecieved = bookLast
            

            
        }
        
    }
 

}
