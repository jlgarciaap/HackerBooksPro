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
            
        }
        
    }
    
    
    @IBAction func readPdf(_ sender: Any) {
    }
    
    @IBOutlet weak var favSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "readPDF" {
            
    
            //De momento como ya lo tenemos todo lo pasamos
            
        
            let selectedPDF = bookRecieved.bookPdf?.pdfData
            
            let pdfDetail: PdfViewController = segue.destination as! PdfViewController
            
            pdfDetail.pdfRecieved = selectedPDF
            
            
            
        }

        
        
        
    }
    

}











