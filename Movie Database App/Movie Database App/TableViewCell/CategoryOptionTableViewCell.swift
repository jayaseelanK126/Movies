//
//  CategoryOptionTableViewCell.swift
//  Movie Database App
//
//  Created by Pyramid on 24/12/21.
//

import UIKit

class CategoryOptionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var posterImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        CSS.customCardView(outerView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
