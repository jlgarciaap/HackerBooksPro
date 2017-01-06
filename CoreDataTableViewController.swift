//
//  CoreDataTableViewController.swift
//  HackerBooksSuperPro
//
//  Created by Juan Luis Garcia on 4/1/17.
//  Copyright © 2017 styleapps. All rights reserved.
//

import UIKit
import CoreData

class CoreDataTableViewController: UITableViewController {
    
    let fecthRequest: NSFetchRequest<Tag> = Tag.fetchRequest()

    var searchResults: Array<Tag> = []
    
    var managedObjectContext: NSManagedObjectContext?
    
    
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
        
        managedObjectContext = getActualContext()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        do {
           // let predicado = NSPredicate(format: "title = %@", "Eloquent JavaScript")
            
           // fecthRequest.predicate = predicado
            
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
        if (searchResults.count > 0)
        {
            
            return searchResults.count
            
        }
        
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        
        if searchResults.count > 0 {
        
        return (searchResults[section].tagBook?.count)!
        
        } else {
            
            return 0
            
        }
        
    
    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        if searchResults.count > 0 {
            
            return searchResults[section].name
            
        } else {

            return ""
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header : UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        header.contentView.backgroundColor = UIColor.blue
        header.textLabel?.textColor = UIColor.white
        
        
    }
    
    //Para la celda seleccionada ponemos el tamaño de la celda
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        return 172.0
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell

   /* Cuando es Books
        if (searchResults.count > 0) {
            
            let title = searchResults[indexPath.row].title
            
            let tagSet  = searchResults[indexPath.row].bookTag
            
            var stringTag : String = ""
            
            for tag in tagSet! {
                
                stringTag += (tag as! Tag).name! + ","
                
                
            }
            
 
 */
           //let authorArray : Array<String> = authorSet?.allObjects as! Array<String>
            
           // let author:String = "Autor de prueba"//authorArray.joined(separator: ",")
        
        
        if (searchResults.count > 0){
            
            let bookSet = searchResults[indexPath.section].tagBook
            
            let bookArray = bookSet?.allObjects as! Array<Book>
            
            let title = bookArray[indexPath.row].title
            
            let tagSet  = bookArray[indexPath.row].bookTag
            
            var stringTag : String = ""
            
            for tag in tagSet! {
                
                stringTag += (tag as! Tag).name! + ","
                
                
            }
            
            let bookPhoto:Photo = bookArray[indexPath.row].bookPhoto!
            
            let image: UIImage = UIImage(data: bookPhoto.photoData as! Data)!
            
            
            
            let authorSet  = bookArray[indexPath.row].bookAuthor
            
            var stringAuthor : String = ""
            
            for author in authorSet! {
                
                stringAuthor += (author as! Author).name! + ","
                
                
            }

            
                
            cell.titleLabelView?.text = title
            cell.tagLabelView?.text = stringTag
            
            cell.imgView.image = image
            //cell.imgView.contentMode = .scaleAspectFit
            
            cell.authorsLabelView?.text = stringAuthor

        }
        
        
        return cell
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
        if segue.identifier == "showBook" {
            
            var indexpath:IndexPath = self.tableView.indexPathForSelectedRow!
            
            let bookSet = searchResults[indexpath.section].tagBook
            
            let bookArray = bookSet?.allObjects as! Array<Book>
            
            let selectedBook: Book = bookArray[indexpath.row]
            
            let bookDetail: DetailBookViewController = segue.destination as! DetailBookViewController
            
            bookDetail.bookRecieved = selectedBook
            
            
            
        }
        
        
    }
 

}
