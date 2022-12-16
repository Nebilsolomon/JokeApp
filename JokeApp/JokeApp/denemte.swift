//
//  denemte.swift
//  JokeApp
//
//  Created by nebil on 11/22/22.
//

import UIKit

class denemte: UIViewController {

    var programmingJoke = "programming"
    var generalJoke = "general"
    var knock_knock_Joke = "knock-knock"
    
    
  //let newJoke = "https://official-joke-api.appspot.com/jokes/random"
   let newJoke = "https://official-joke-api.appspot.com/jokes/general/random"
   
    var url:URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         url = URL(string: newJoke)
    getDAta()
        //print("V")
    }
    

    func getDAta()  {
        print("getting data")
        let task = URLSession.shared.dataTask(with: url!) {(data,response,error) in
          
//            if let safeData = data {
//
//                let dataString = String(data: safeData, encoding: .utf8)
//                print(dataString!)
//            }
            
            
            let decoder = JSONDecoder()

            if let data = data {
                if let jokesx = try? decoder.decode([Jokes].self, from: data) {

                    print(jokesx[0].setup)

                    print("=======================")


                }
            }
            
     
                
             
            
            
            
        }
        task.resume()
    }

    struct Jokes:Codable {
       let type:String
       let setup:String
       let punchline:String
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
