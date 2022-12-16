//
//  ChangeImageViewController.swift
//  JokeApp
//
//  Created by nebil on 12/3/22.
//

import UIKit

class ChangeImageViewController: UIViewController {
    var userDef = UserDefaults.standard

    
    @IBOutlet var button1: UIButton!
    
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        button1.clipsToBounds = true
        button1.contentMode = .scaleAspectFill

        // Use setBackgroundImage or setImage
        button1.setBackgroundImage(UIImage(named: "a.jpg"), for: .normal)
        
        
        button2.clipsToBounds = true
        button2.contentMode = .scaleAspectFill

        // Use setBackgroundImage or setImage
        button2.setBackgroundImage(UIImage(named: "b.jpg"), for: .normal)
        
        button3.clipsToBounds = true
        button3.contentMode = .scaleAspectFill

        // Use setBackgroundImage or setImage
        button3.setBackgroundImage(UIImage(named: "c.jpg"), for: .normal)
        
        
        button4.clipsToBounds = true
        button4.contentMode = .scaleToFill

        // Use setBackgroundImage or setImage
        button4.setBackgroundImage(UIImage(named: "d.jpg"), for: .normal)
        
        
        
        
        
        
    }
    
    
    @IBAction func changeImage(_ sender: UIButton) {
        
        if sender.tag == 1 {
            userDef.set("a.jpg", forKey: "image")

            
            
        }
        else if sender.tag == 2 {
            userDef.set("b.jpg", forKey: "image")

            
        }
        else if sender.tag == 3 {
            userDef.set("c.jpg", forKey: "image")
            
        }
        else if sender.tag == 4 {
            userDef.set("d.jpg", forKey: "image")
            
        }
        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
