import UIKit

class ToDoListCell: UITableViewCell
{

    @IBOutlet weak var backView: UIView!
    {
    didSet
        {
            backView.layer.cornerRadius = backView.frame.height / 5
            backView.layer.borderColor = UIColor.black.cgColor
            backView.layer.borderWidth = 1
            
        }
    }
    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var upBtnOutLet: UIButton!
    @IBOutlet weak var downBtnOutLet: UIButton!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

    }

}
