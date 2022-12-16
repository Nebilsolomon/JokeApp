//
//  EnterYourOwnViewController.swift
//  JokeApp
//
//  Created by Long Nguyen on 11/23/22.
//

import Foundation

import UIKit
import CoreData


class EnterYourOwnViewController: UIViewController {
    
    var allOfTheJokes = [Jokes]()
    
    @IBOutlet weak var ChangeBackGroundTextField: UITextField!
    
    @IBOutlet weak var SaveBackground: UIButton!
    
    @IBOutlet weak var loadBackground: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    @IBOutlet weak var EnterJoke: UILabel!
    
    @IBOutlet weak var EnterJokeField: UITextField!
    
    @IBOutlet var Answer: UITextField!
    
    var myPersistence = MyPersistence()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        
        
    }
    
    @IBAction func loadBgButtonClicked(_ btn: UIButton) {
        print("Load Background button clicked")
        let timer = MyTimer()
        
        if let urlAsString = self.ChangeBackGroundTextField.text
        {
            if(self.myPersistence.isFileInCache(fileKey: urlAsString) == false)
            {
                self.myPersistence.loadFileToCache(urlAsString: urlAsString)
                {
                    (fileData) in
                    self.view.backgroundColor = UIColor(patternImage: UIImage(data: fileData)!)
                    print("loading file from URL and saving to cache took \(timer.get())s")
                }
                //self.view.backgroundColor = UIColor(patternImage:  UIImage(data:  data!)!)
                // self.theImage.image = UIImage(data: data!)
            }
            
            else
            {
                if let data = self.myPersistence.loadFileFromCache(fileKey: urlAsString)
                {
                    
                    self.view.backgroundColor = UIColor(patternImage:  UIImage(data:  data)!)
                    print("loaded file directly from cache took \(timer.get())s")
                    //print("Loading file directly from cache took \(timer.get())s")
                }
                else
                {
                    print("Failed to load file from cache")
                }
            }
        }
    }
    
    @IBAction func SaveBgButtonClicked(_ sender: Any) {
        print("Save Background button clicked")
         
        let urlAsString = self.ChangeBackGroundTextField.text ?? ""
        let url = URL(string: urlAsString)
        if let fileName = url?.lastPathComponent{
            if( self.myPersistence.isFileInCache(fileKey: urlAsString)){
                if let data = self.myPersistence.loadFileFromCache(fileKey: urlAsString)
                {
                    self.myPersistence.saveFileToUserFolder(fileName: fileName, data: data)
                }
            }
        }
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        print("Save button pressed")
        let newJoke = Jokes(context: context)
        var textField = UITextField()
        
       

        let alert = UIAlertController(title: "Rate Joke 1-10", message: "", preferredStyle: .alert)
        


        let action = UIAlertAction(title: "Confrim", style: .default) { [self] (action) in
            
            //print(" it is ========= \(textField.text!)")
            
            
            if let  convertToInt = Int(textField.text!) as? Int {
                
                
                
                if(convertToInt >= 1 && convertToInt <= 10 ) {
                               
                      
                    let uuid = UUID().uuidString
                        newJoke.joke =  EnterJokeField.text
                        newJoke.answerxxxxx = Answer.text
                        newJoke.jokeId = uuid
                           
                        newJoke.jokeNumber = textField.text!
                        allOfTheJokes.append(newJoke)
                        saveData()
                    
                    print("Success, rating score is \(textField.text)")
                               
                               
               }
               else {
                     
                print("ERROR rating is not ")
                present(alert, animated: true, completion: nil)
                         
               
               
               }

            }
            
            
           
            
            
            
        
////
//
//
        }
        
        
        alert.addTextField { [self] (alertTextFieldx) in
            alertTextFieldx.placeholder = "Number"
            
            textField = alertTextFieldx
         
            
        }
        textField.keyboardType = UIKeyboardType.numberPad
        
        
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
//        let uuid = UUID().uuidString
//       let newJoke = Jokes(context: context)
//
//        newJoke.joke =  EnterJokeField.text
//        newJoke.answerxxxxx = Answer.text
//
//        newJoke.jokeId = uuid
//
       //allOfTheJokes.append(newJoke)
//        saveData()
    //    print(EnterJokeField.text)
        
    }
    
    
    
    
    func saveData()  {
        
        do {
           try context.save()
            
        }catch {
            print("error )))))))))))))))))))))")
            
            
        }
        
    }



}




