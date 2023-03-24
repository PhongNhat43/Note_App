//
//  UsersTableViewCell.swift
//  123
//
//  Created by devsenior on 21/03/2023.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLbL: UILabel!
    
    @IBOutlet weak var descLbl: UILabel!
    
    @IBOutlet weak var createAt: UILabel!
    
    @IBOutlet weak var levelLbL: UILabel!
    static let identifier = "UsersTableViewCell"
        
        static func nib() -> UINib {
           return UINib(nibName: "UsersTableViewCell", bundle: nil)
        }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
