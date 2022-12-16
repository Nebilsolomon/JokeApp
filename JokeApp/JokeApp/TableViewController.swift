
import UIKit
import CoreData

class TableViewController: UITableViewController {
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var indexAnswer = 0
    @IBOutlet weak var tableViews: UITableView!
    var allJokes = [Jokes]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadJoke()
        
        
//        title = "My Jokes"
//        if let unwrapper = tableViews{
//            tableViews.register(UITableView.self, forCellReuseIdentifier:"Cell")
//        }
//        else
//        {
//            print("error found nil")
//        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
//    override func viewDidAppear(animated: Bool)
//    {
//        super.viewDidAppear(animated)
//        tableViews.reloadData()
//    }

//    @IBAction func makeMyOwnJoke(_ sender: Any) {
//    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    
        return allJokes.count
    
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel!.numberOfLines = 0;
      //  cell.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        
        //cell.textLabel?.numberOfLines = 10
        cell.textLabel?.text = allJokes[indexPath.row].joke
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableView.automaticDimension
       }
    
    func loadJoke()  {
        print("Loading joke")
        let request:NSFetchRequest<Jokes> = Jokes.fetchRequest()
        
        do {
            allJokes = try context.fetch(request)
        } catch {
            print("Error while loading joke")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "showAnswer" {
            if let des = segue.destination as? JokeAnswerViewController {
                des.jokeAnswer = allJokes[indexAnswer].answerxxxxx!
                des.id = allJokes[indexAnswer].jokeId!
                
                if let jokeNum = allJokes[indexAnswer].jokeNumber  {
                
                des.jokeNum = jokeNum
                
                }
            }
        }
        
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        indexAnswer = indexPath.row
        performSegue(withIdentifier: "showAnswer", sender: self)

      //  allJokes[indexPath.row].done =  !allJokes[indexPath.row].done
//        context.delete(allJokes[indexPath.row])
//        allJokes.remove(at: indexPath.row)
//
      // saveJoke()
    
        
        
    }
    
    func saveJoke()  {
        do {
           try context.save()
            
        }catch {
            print("error could not save joke")
            
            
        }
        tableView.reloadData()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            context.delete(allJokes[indexPath.row])
            allJokes.remove(at: indexPath.row)
            saveJoke()
            
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
    }
    }

    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension TableViewController: UITableViewDataSource
//{
//    func tableView(_tableView:UITableView,numberOfRowsInSection section: Int) ->Int{
//        return jokes?.allOfTheJokes.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell
//    {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.textLabel?.text= names[indexPath.row]
//        return cell
//    }
//}
