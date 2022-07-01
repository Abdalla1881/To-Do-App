import UIKit
import DGElasticPullToRefresh

class ToDoVC: UIViewController
{

    @IBOutlet weak var tableView: UITableView!
    
    var toDoArray : [getToDo] = []
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        setupUI()
        pullToRefresh()
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        

        
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        tableView.dg_removePullToRefresh()
    }
    
    //MARK:- IBAction
    
    @IBAction func goToAddVC(_ sender: UIBarButtonItem)
    {
        let addVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AddToDoVC") as! AddToDoVC
        addVC.delegate = self
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    @objc func upBtnPressed(_ sender: UIButton)
    {
        if sender.tag != 0
           {
               toDoArray.swapAt(sender.tag, sender.tag - 1)
               tableView.reloadData()
           }
    }
    
    @objc func downBtnPressed(_ sender: UIButton)
    {
        if sender.tag != toDoArray.count - 1
            {
                toDoArray.swapAt(sender.tag, sender.tag + 1)
                tableView.reloadData()
            }
    }
    
    
    //MARK:- Helper Functions
    
    func setupUI()
    {
       // da lo hn4el al 5tot aly t7t al cell  tableView.tableFooterView = UIView()
       // lakn de kol al 5tot 
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func pullToRefresh()
    {
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            // Add your logic here
            // Do not forget to call dg_stopLoading() at the end
            self?.tableView.dg_stopLoading()
        }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(#colorLiteral(red: 0.2, green: 0.5450980392, blue: 0.937254902, alpha: 1))
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
    }
}



extension ToDoVC : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return toDoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ToDoListCell
        cell.toDoLabel.text = toDoArray[indexPath.row].list
        
        cell.upBtnOutLet.tag = indexPath.row
        cell.downBtnOutLet.tag = indexPath.row
        
        cell.upBtnOutLet.addTarget(self, action: #selector(self.upBtnPressed(_:)), for: .touchUpInside)
        cell.downBtnOutLet.addTarget(self, action: #selector(self.downBtnPressed(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Constants.SCREENHeight / 12
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let delete = UIContextualAction(style: .normal, title: "Delete")
        {(action , view , completion) in
            self.toDoArray.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        delete.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        let swip = UISwipeActionsConfiguration(actions: [delete])
        swip.performsFirstActionWithFullSwipe = false
        return swip
        
    }
}


extension ToDoVC : toDoItem
{
   func addNewItem(item: getToDo)
   {
      toDoArray.append(item)
      tableView.reloadData()
   }
}

