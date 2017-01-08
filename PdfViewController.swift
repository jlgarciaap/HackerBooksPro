//
//  PdfViewController.swift
//  HackerBooksSuperPro
//
//  Created by Juan Luis Garcia on 5/1/17.
//  Copyright © 2017 styleapps. All rights reserved.
//

import UIKit

class PdfViewController: UIViewController, UIWebViewDelegate{
    
    var pdfRecieved:Pdf!
    
    let miDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var actViw: UIActivityIndicatorView!
    
    @IBOutlet weak var pdfView: UIWebView!{
        
        didSet{
            
            pdfView.delegate = self
            
            
            if pdfRecieved.pdfData == nil {
                
                let pdfData = NSData(contentsOf: NSURL(string: pdfRecieved.urlPdf!) as! URL)
                
                
                if pdfData == nil {
                    
                    let alertController = UIAlertController(title: "Surprise Error jeje", message: "The Dark Side has stolen this book, the Rebel Alliance will retrieve it. The force is with us", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler:{ (action) in
                        
                        
                        self.dismiss(animated: true, completion: nil)
                        
                    }))
                    
                    
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    
                    
                } else {
                    
                    pdfRecieved.pdfData = pdfData
                    
                    miDelegate.saveContext()
                    
                    self.pdfView.load(pdfData as! Data, mimeType: "application/pdf", textEncodingName: "utf-8", baseURL:NSURL().absoluteURL!)
                }
                
            } else {
                
                
                self.pdfView.load(pdfRecieved.pdfData as! Data, mimeType: "application/pdf", textEncodingName: "utf-8", baseURL:NSURL().absoluteURL!)
                
            }
        }
        
        
    }

    override func viewDidLoad() {
        //Vista por debajo del NavBar
        self.edgesForExtendedLayout = UIRectEdge()
        
        actViw.startAnimating()
        
    
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UIViewDelegate
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //delegado del webView
        
        
        
        actViw.stopAnimating()
        actViw.hidesWhenStopped = true
       
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
