//
//  GitTVC.swift
//  bCash
//
//  Created by Mahmud on 2021-09-14.
//

import UIKit

class GitTableViewCell: UITableViewCell {

    // this method will help us to add a padding to tableview cell
    // as we are not using any custom cell for now
    // it's a quick way of doing it
    // from stackoverflow
    override open var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 10
            frame.origin.x += 10
            frame.size.height -= 15
            frame.size.width -= 2 * 10
            super.frame = frame
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        layoutSubviews()
    }


}

