//
//  JokeAnswerViewController.swift
//  JokeApp
//
//  Created by nebil on 12/3/22.
//

import UIKit

class JokeAnswerViewController: UIViewController {

            var userDef = UserDefaults.standard
            var imageName:String?
            let  button = UIButton()
            let myLabel = UILabel()
            let myLabel2 = UILabel()
             let myLabel3 = UILabel()
            var backimage:UIImage?
            var jokeAnswer = ""
            var jokeNum = ""
            var id = ""
           
    
    
    
      

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if userDef.string(forKey: "image") == nil {
            userDef.set("b.jpg", forKey: "image")
           imageName = userDef.string(forKey: "image")!
        
        
        }
        else {
           
            
            
            imageName = userDef.string(forKey: "image")!
            
        }

      
        
        
        
        
        constrainLabel()
        myLabel2.lineBreakMode = .byWordWrapping // notice the 'b' instead of 'B'
        myLabel2.numberOfLines = 0
        
        
        myLabel.lineBreakMode = .byWordWrapping // notice the 'b' instead of 'B'
        myLabel.numberOfLines = 0
       
        
        // Do any additional setup after loading the view.
    }
    
    
    func constrainLabel()  {
        print(imageName)
        self.view.backgroundColor =  UIColor(patternImage: UIImage(named:imageName!)!)

        button.setTitle("Change Image", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
      //  button.textAlignment = .center
         self.view.addSubview(button)

        
        
        
              myLabel2.backgroundColor = .yellow
               myLabel2.translatesAutoresizingMaskIntoConstraints = false
               myLabel2.text = id
              // myLabel2.frame.size  = CGSize(width: self.view.frame.width, height: 400)
               myLabel2.textAlignment = .center
        self.view.addSubview(myLabel2)
        
        
        myLabel.backgroundColor = .yellow
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.text = jokeAnswer
             //myLabel.frame.size  = CGSize(width: self.view.frame.width, height: 400)
             myLabel.textAlignment = .center
             view.addSubview(myLabel)
        
        
        myLabel3.backgroundColor = .yellow
        myLabel3.translatesAutoresizingMaskIntoConstraints = false
        myLabel3.text = jokeNum
             //myLabel.frame.size  = CGSize(width: self.view.frame.width, height: 400)
        myLabel3.textAlignment = .center
             view.addSubview(myLabel3)
        
        
        
        
        
        let margineGuide = view.layoutMarginsGuide
             NSLayoutConstraint.activate([
                 
                myLabel2.topAnchor.constraint(equalTo: margineGuide.topAnchor, constant: 240),
                myLabel2.leadingAnchor.constraint(equalTo: margineGuide.leadingAnchor),
                myLabel2.heightAnchor.constraint(equalToConstant: 40),
                myLabel2.trailingAnchor.constraint(equalTo: margineGuide.trailingAnchor),
                
               
                
                myLabel3.topAnchor.constraint(equalTo: margineGuide.topAnchor, constant: 180),
                myLabel3.leadingAnchor.constraint(equalTo: margineGuide.leadingAnchor),
                myLabel3.heightAnchor.constraint(equalToConstant: 40),
                myLabel3.trailingAnchor.constraint(equalTo: margineGuide.trailingAnchor),
                
                
                
                 
                 
                 
                 
                myLabel.topAnchor.constraint(equalTo: margineGuide.topAnchor, constant: 120),
                myLabel.leadingAnchor.constraint(equalTo: margineGuide.leadingAnchor),
                myLabel.heightAnchor.constraint(equalToConstant: 40),
                myLabel.trailingAnchor.constraint(equalTo: margineGuide.trailingAnchor),
                 
                 
                
                button.bottomAnchor.constraint(equalTo: margineGuide.bottomAnchor, constant: 20),
             //   button.topAnchor.constraint(equalTo: margineGuide.topAnchor, constant: 20),
                button.leadingAnchor.constraint(equalTo: margineGuide.leadingAnchor),
                button.heightAnchor.constraint(equalToConstant: 40),
                button.trailingAnchor.constraint(equalTo: margineGuide.trailingAnchor)
                
             
             ])
             
             self.view = view
        
        
        
        
        
        
    }
  
    
    @objc func buttonAction()  {
        userDef.set("a.jpg", forKey: "image")

     
        performSegue(withIdentifier: "imageChange", sender: self)
        
     
        
//        userDef.set("b.jpg", forKey: "image")

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
