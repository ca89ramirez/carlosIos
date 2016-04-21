//
//  ViewController.swift
//  HttpCarlos
//
//  Created by Carlos Ramirez Velazquez on 4/5/16.
//  Copyright © 2016 Carlos Ramirez Velazquez. All rights reserved.
//

import UIKit
import SystemConfiguration


class ViewController: UIViewController {
    
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var libro: UILabel!
    @IBOutlet weak var autor: UILabel!
    @IBOutlet weak var portada: UILabel!
    @IBOutlet weak var textoISB: UITextField!
    @IBAction func limparCampos(sender: AnyObject) {
        textArea.text = " "
        textoISB.text = " "
        libro.text = " "
        autor.text = " "
        portada.text = " "
    }
    
    @IBOutlet weak var textArea: UITextView!
       @IBAction func BuscarButton(sender: UIButton) {
        
        print("Hello world")
        if isConnectedToNetwork() == true {
            print("Internet connection OK")
            sincrono()
        } else {
            print("Internet connection FAILED")
        }
    
        
        print("bye")
        
        
    }

    func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) { SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0)) }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func sincrono(){
        var ISB = String()
        ISB = textoISB.text!
        
      
    
        
        if ISB.isEmpty{
            print("-Estado vacio-----")
            libro.text = "Ingrese un ISBN"
        }else{
        
        print(ISB)
        print("-------")
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(ISB)"
        print(urls)
    //    let urls="https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:9788437604947"
        print("-------")
        let url=NSURL(string: urls)
        let datos : NSData? =  NSData(contentsOfURL:url!)
        let comp = NSString (data: datos!, encoding: NSUTF8StringEncoding)
        if comp == "{}" {
            print("-Código Erroneo--")
            libro.text = "No existe el ISBN "

        }else{
                        do{
                let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                let dico1 = json as! NSDictionary
                let dico2 = dico1["ISBN:\(ISB)"] as! NSDictionary
                let title = dico2["title"] as? String
                libro.text = title
                print ("mi titulo \(title)")
                /* let dico3 = dico2["publishers"] as? [[String : AnyObject]]
                if let publishers = dico3["publishers"] as? [AnyObject]{
                for nombre in publishers{
                }
                }*/
                let dico3 = dico2 ["publishers"] as! [[String:AnyObject]]
                for publish in dico3 {
                    let publicacion = publish["name"] as? String
                    print("mi pub \(publicacion)")
                    portada.text = publicacion   }
                let name = dico3.first
                print("-----")
                print(name)
                print("-----")
                let dico4 = dico2["authors"] as! [[String:AnyObject]]
                let auto = dico4.first
                print("-----")
                print(auto)
                print("-----")
                for autoor in dico4 {
                    let author = autoor["name"] as? String
                    print("mi autor \(author)")
                    autor.text = author
                }
                let imageURL = NSURL(string: "http://covers.openlibrary.org/b/isbn/\(ISB)-L.jpg")!
                let image = NSData(contentsOfURL: imageURL)!
                imagen.image = UIImage(data: image)
            }
            catch _{
            }
            }}
     /*   if datos != nil{
            print("no nulo")
            let texto = NSString(data:datos!, encoding:NSUTF8StringEncoding)
            textArea.text = texto as! String
            //libro.text = texto as? String
            if texto == "{}"{
                textArea.text = "No se encontró el ISB ingresado"
                print("no se encontro")
            }
        }
        else{
            textArea.text = "No se cuenta con acceso a Internet"
        }*/
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

