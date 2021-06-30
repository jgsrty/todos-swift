//
//  TodoCell.swift
//  todos-swift
//
//  Created by 荣天阳 on 2021/6/30.
//

import UIKit

class TodoCell: UITableViewCell {

	@IBOutlet weak var checkMark: UILabel!
	@IBOutlet weak var todo: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
