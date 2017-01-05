//
//  PdfViewController.swift
//  HackerBooksSuperPro
//
//  Created by Juan Luis Garcia on 5/1/17.
//  Copyright © 2017 styleapps. All rights reserved.
//

import UIKit

class PdfViewController: UIViewController {
    
    var pdfRecieved:NSData!
    
    @IBOutlet weak var actViw: UIActivityIndicatorView!
    
    @IBOutlet weak var pdfView: UIWebView!{
        
        didSet{
            
            actViw.startAnimating()
            
            self.pdfView.load(pdfRecieved as Data, mimeType: "application/pdf", textEncodingName: "utf-8", baseURL:NSURL().absoluteURL!)
            
            actViw.stopAnimating()
            
        }
        
        
    }

    override func viewDidLoad() {
        //Vista por debajo del NavBar
        self.edgesForExtendedLayout = UIRectEdge()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
