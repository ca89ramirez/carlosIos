//
//  ViewController.swift
//  HttpCarlos
//
//  Created by Carlos Ramirez Velazquez on 4/5/16.
//  Copyright © 2016 Carlos Ramirez Velazquez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textoISB: UITextField!
    
    @IBAction func limparCampos(sender: AnyObject) {
        textArea.text = " "
        textoISB.text = " "
    }
    @IBOutlet weak var textArea: UITextView!
    @IBAction func BuscarButton(sender: UIButton) {
        print("Hello world")
        sincrono()
        print("bye")
    }
    func sincrono(){
        
        var ISB = String()
        ISB = textoISB.text!
        print(ISB)
        print("-------")
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(ISB)"
        print(urls)
    //    let urls="https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:9788437604947"
        print("-------")
        let url=NSURL(string: urls)
        let datos : NSData? =  NSData(contentsOfURL:url!)
        let texto = NSString(data:datos!, encoding:NSUTF8StringEncoding)
        
        print(texto!)
        print (ISB)
        textArea.text = texto as! String
       // 9788437604947
         }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

