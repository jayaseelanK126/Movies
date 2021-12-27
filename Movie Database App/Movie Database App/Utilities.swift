//
//  Utilities.swift
//  Movie Database App
//
//  Created by Pyramid on 26/12/21.
//

import UIKit

class CSS: NSObject
{
    static func customCardView(_ view: UIView?,Bgcolor : UIColor = .white,BorderColor: UIColor = .lightGray, borderWidth: CGFloat = 0.2, cornerRadius: CGFloat = 5.0, isClipsToBounds: Bool = false, isDefaultValues: Bool = true)
    {
        if let view = view
        {
            view.backgroundColor = Bgcolor
            view.layer.cornerRadius = isDefaultValues ? 13.0 : cornerRadius
            view.layer.borderColor = isDefaultValues ? UIColor.clear.cgColor : BorderColor.cgColor
            view.layer.borderWidth = isDefaultValues ? 0.0 : (borderWidth)
            view.layer.shadowColor = BorderColor.cgColor
            view.layer.shadowOpacity = isDefaultValues ? 0.5 : 0.5
            view.layer.shadowRadius = isDefaultValues ? 6.0 : 3.0
            view.layer.shadowOffset = isDefaultValues ? CGSize(width: 0, height: 0) : CGSize(width: 0, height: 2)
            view.clipsToBounds = isClipsToBounds
        }
    }
    
    static func customButton(button: UIButton, titleNormalColor: UIColor, titleSelectedColor: UIColor, backgroundColor: UIColor = .blue, isBorder: Bool = false, borderColor: UIColor = .white, borderWidth: CGFloat = 0.0, isRoundCorner: Bool = false, cornerRadius: CGFloat = 2.0, isShadow: Bool = false)
    {
       
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = isRoundCorner ? button.frame.size.height / 2 : cornerRadius
        button.setTitleColor(titleNormalColor, for: .normal)
        button.setTitleColor(titleSelectedColor, for: .selected)
        button.tintColor = UIColor.clear
        button.backgroundColor = backgroundColor
        
        if isBorder
        {
            button.layer.borderColor = borderColor.cgColor
            button.layer.borderWidth = borderWidth
        }
        else
        {
            button.layer.borderColor = UIColor.clear.cgColor
            button.layer.borderWidth = 0
        }
        
        if isShadow
        {
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 1.0)
            button.layer.shadowOpacity = 0.5
            button.layer.shadowRadius = 1.0
            button.clipsToBounds = false
        }
        else
        {
            button.clipsToBounds = true
        }
    }
}


// MARK: - Data Model

struct CategoryNames {
    static let Year = "Year"
    static let Genre = "Genre"
    static let Directors = "Directors"
    static let Actors = "Actors"
    
}
