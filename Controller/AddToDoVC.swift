import UIKit


protocol toDoItem
{
    func addNewItem (item : getToDo)
}

class AddToDoVC: UIViewController
{

    //MARK:- OutLet
    
    
    @IBOutlet weak var toDoTF: UITextField!
    
    @IBOutlet weak var AddBTNOutLet: UIButton!
        {
            didSet
                {
                    AddBTNOutLet.layer.cornerRadius = AddBTNOutLet.frame.height / 2
                    AddBTNOutLet.layer.borderWidth = 3
                    AddBTNOutLet.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                }
        }
    
    //MARK:- Constants
    
    
    var delegate : toDoItem?
    var myGetList : getToDo!
    static var flag = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        if AddToDoVC.flag == 1
        {
            delegate?.addNewItem(item: myGetList!)
            AddToDoVC.flag = 0
        }
        
    }
  
    
    //MARK:- IBAction
    
    @IBAction func addNewItemBtnPressed(_ sender: UIButton)
    {
        if toDoTF.text != ""
        {
            myGetList = getToDo(list : toDoTF.text!)
            AddToDoVC.flag = 1
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Empty Text Field", preferredStyle: .actionSheet)
            let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
             let alertAction2 = UIAlertAction(title: "OK", style: .default)
                {
                   (action) in
                   self.dismiss(animated: true, completion: nil)
                }
            
            let alertAction3 = UIAlertAction(title: "Des", style: .destructive)
                {
                   (action) in
                   self.dismiss(animated: true, completion: nil)
                }

            alert.addAction(alertAction)
            alert.addAction(alertAction2)
            alert.addAction(alertAction3)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    //MARK:- Helper Functions

}
