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
    
    let fecthRequest: NSFetchRequest<Book> = Book.fetchRequest()

    var searchResults: Array<Book> = []
    
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
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)

   
        if (searchResults.count > 0) {
            
            let title = searchResults[indexPath.row].title
            
            let tagSet  = searchResults[indexPath.row].bookTag
            
            var stringTag : String = ""
            
            for tag in tagSet! {
                
                stringTag += (tag as! Tag).name! + ","
                
                
            }
            
           //let authorArray : Array<String> = authorSet?.allObjects as! Array<String>
            
           // let author:String = "Autor de prueba"//authorArray.joined(separator: ",")
            
            
            cell.textLabel?.text = title
            cell.detailTextLabel?.text = stringTag
            
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
