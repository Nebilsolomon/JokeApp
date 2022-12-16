


import UIKit
import CoreData

class ViewController: UIViewController {
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
 
        
    let userDefaults = UserDefaults.standard
    let ON_OFF_KEY = "onOffKey"
    let THEME_KEY = "themeKey"
    let DEFAULT_THEME = "defaultTheme"
    let INVERTED_THEME = "invertedTheme"
    
    
    @IBOutlet weak var onOffSwitch: UISwitch!
    
    @IBOutlet var jokeLabel: UILabel!
  
    @IBOutlet weak var punchLine: UILabel!
    
    var jokeApi = ""
    
    var reNewJoke = ""
    
    var rePunchLine = ""
 
    var url:String!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
        checkSwitchState()
        updateTheme()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        //var path: [AnyObject] = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true) as [AnyObject]
        //let folder: String = path[0] as! String

        jokeLabel.lineBreakMode = .byWordWrapping // notice the 'b' instead of 'B'
        jokeLabel.numberOfLines = 0
        
        
        punchLine.lineBreakMode = .byWordWrapping // notice the 'b' instead of 'B'
        punchLine.numberOfLines = 0

    }


    
    func getDAta(apiRequest: String )  {
        print("getting data")
        print("printing url \(apiRequest)")
        
        let url = URL(string: apiRequest)!
        let task = URLSession.shared.dataTask(with: url) { [self](data: Data?,response: URLResponse?,error: Error?) in
            
            if let error = error
            {
                print("error", error)
                return
            } //for validating data
            guard let httpResponse = response as? HTTPURLResponse else
            {
                print("not the right response")
                return
            } //for validating data
            
            guard (200...299).contains(httpResponse.statusCode) else
            {
                print("Error, status code", httpResponse.statusCode)
                return
            } //for validating data
            guard let data = data else {
                print("bad data")
                return
            } //for vallidating data
            
            //print("task entered")
            let decoder = JSONDecoder()

            if let data:Data? = data {
                if let jokesx = try? decoder.decode([JokesType].self, from: data!) {

                    //jokeLabel.text = jokesx[0].setup
                //    self.jokeLabel.text = jokesx.setup

                   // print(jokesx[0].setup)

                    self.reNewJoke = jokesx[0].setup // joke api
                    self.rePunchLine = jokesx[0].punchline
                    
                    //print("printing joke from getData\(self.reNewJoke)")
                    //print("printing punchLine from getData\(self.rePunchLine)")
                    
                  //  self.jokeLabel.text = jokesx[0].setup
                    
                   // self.updateLabel()
                    // print(jokesx.punchline)\
                    
                //    jokeLabel.text = reNewJoke
        
                }
                
               
            }

            DispatchQueue.main.async{
                self.jokeLabel.text = reNewJoke
                self.punchLine.text = rePunchLine
            }
          


        }
        
        task.resume()
        //self.update()
    }

    struct JokesType:Codable {
      // let type:String
       let setup:String
       let punchline:String
    }




    @IBAction func typeJoke(_ sender: UIButton) {
       // var newJoke = ""
        if sender.tag == 1 {
      //  newJoke = "https://official-joke-api.appspot.com/jokes/random"

         
          jokeApi = "https://official-joke-api.appspot.com/jokes/programming/random"
        }
        else if sender.tag == 2  {

            jokeApi = "https://official-joke-api.appspot.com/jokes/general/random"




      
        }
        else if sender.tag == 3 {
           
              jokeApi = "https://official-joke-api.appspot.com/jokes/random"


           // newJoke = "https://official-joke-api.appspot.com/jokes/knock-knock/random"


        }


       // url = URL(string: jokeApi)
       
        getDAta(apiRequest: jokeApi)
//        jokeLabel.text = reNewJoke
        //print(" ****JokeLabel***** \(jokeLabel.text!)")
        //print(" ^^^^reNewJoke^^^^^\(reNewJoke)")

    }
    
    func updateTheme()
    {
        let theme = userDefaults.string(forKey: THEME_KEY)
        if (theme == DEFAULT_THEME)
        {
            view.backgroundColor = UIColor.systemYellow
            jokeLabel.backgroundColor = UIColor.systemYellow
            punchLine.backgroundColor = UIColor.systemYellow
        }
        if (theme == INVERTED_THEME)
        {
            view.backgroundColor = UIColor.systemPink
            jokeLabel.backgroundColor = UIColor.systemPink
            punchLine.backgroundColor = UIColor.systemPink
            
        }
        
    }
    
    func checkSwitchState()
    {
        if(userDefaults.bool(forKey: ON_OFF_KEY))
        {
            onOffSwitch.setOn(true, animated: false)
            
            
        }
        else
        {
            onOffSwitch.setOn(false, animated: false)
            
        }
    }
 
    @IBAction func lightSwitch(_ sender: Any) {
        if(onOffSwitch.isOn)
        {
            userDefaults.set(true, forKey: ON_OFF_KEY)
            userDefaults.set(DEFAULT_THEME, forKey: THEME_KEY)
            updateTheme()
            
        }
        else
        {
            userDefaults.set(false, forKey:ON_OFF_KEY)
            userDefaults.set(INVERTED_THEME, forKey: THEME_KEY)
            updateTheme()
        }
    }
    
    @IBAction func showJoke(_ sender: Any)
    {
        print("Show my joke button pressed")
    }
    
   
    @IBAction func saveJoke(_ sender: UIButton) {
        //var validInput: Bool = true
        print("save button pressed")
      
        
        
        let newJoke = Jokes(context: context)
       
        
        var textField = UITextField()
        
       

        let alert = UIAlertController(title: "Rate Joke 1-10", message: "", preferredStyle: .alert)
        


        let action = UIAlertAction(title: "Confrim", style: .default) { [self] (action) in
            
            //print(" it is ========= \(textField.text!)")
            
            
            if let  convertToInt = Int(textField.text!) as? Int {
                
                
                
                if(convertToInt >= 1 && convertToInt <= 10 ) {
                               
                      
                    let uuid = UUID().uuidString
                             newJoke.joke =  reNewJoke
                             newJoke.answerxxxxx = rePunchLine
                             newJoke.jokeId = uuid
                           
                       
                            newJoke.jokeNumber = textField.text!
                        
                            saveJoke()
                    
                    print("Success, rating score is \(textField.text)")
                               
                               
               }
               else {
                     
                print("ERROR rating is not ")
                present(alert, animated: true, completion: nil)
                         
               
               
               }

            }
            
            
        }
        
        
        alert.addTextField { [self] (alertTextFieldx) in
            alertTextFieldx.placeholder = "Number"
            
            textField = alertTextFieldx
         
            
        }
        textField.keyboardType = .decimalPad
        
        
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
//        print("save Button pressed")
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
//        {
//            return
//        }
//
//        let context = appDelegate.persistentContainer.viewContext
//      //  print("savebutton clicked \(reNewJoke)")
//
//        let entity = NSEntityDescription.entity(forEntityName: "Jokes", in: context)!
//
//        let joke = NSManagedObject(entity: entity, insertInto: context)
////
     //   joke.setValue(reNewJoke, forKeyPath: "joke")

        
        
        
        
        
        
//        let uuid = UUID().uuidString
//         newJoke.joke =  reNewJoke
//         newJoke.answerxxxxx = rePunchLine
//         newJoke.jokeId = uuid
//
     
        
      
    
    
    }
    
    
    func saveJoke()  {
        
        do {
           try context.save()
            
        }catch {
            print("error cannot save joke")
            
            
        }
    
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        // Handle backspace/delete
        guard !string.isEmpty else {

            // Backspace detected, allow text change, no need to process the text any further
            return true
        }

        // Input Validation
        // Prevent invalid character input, if keyboard is numberpad
        if textField.keyboardType == .numberPad {

            // Check for invalid input characters
            if CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) {

                // Present alert so the user knows what went wrong
                print("This field accepts only numeric entries.")

                // Invalid characters detected, disallow text change
                return false
            }
        }

        // Length Processing
        // Need to convert the NSRange to a Swift-appropriate type
        if let text = textField.text, let range = Range(range, in: text) {

            let proposedText = text.replacingCharacters(in: range, with: string)

            // Check proposed text length does not exceed max character count
            guard proposedText.count <= 2 else {

                // Present alert if pasting text
                // easy: pasted data has a length greater than 1; who copy/pastes one character?
                if string.count > 1 {

                    // Pasting text, present alert so the user knows what went wrong
                    print("Paste failed: Maximum character count exceeded.")
                }

                // Character count exceeded, disallow text change
                return false
            }

            // Only enable the OK/submit button if they have entered all numbers for the last four
            // of their SSN (prevents early submissions/trips to authentication server, etc)
            //action.isEnabled = (proposedText.count == 4)
        }

        // Allow text change
        return true
    }
    
//    func isValidInput(testStr:String) -> Bool {
//        let emailRegEx = "[0-9.]+[0-9]"
//        if let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx) as NSPredicate? {
//            return emailTest.evaluateWithObject(testStr)
//        }
//        return false
//    }

}
