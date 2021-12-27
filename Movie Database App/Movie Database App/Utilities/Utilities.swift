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

}


// MARK: - Data Model

struct CategoryNames {
    static let Year = "Year"
    static let Genre = "Genre"
    static let Directors = "Directors"
    static let Actors = "Actors"
    
}


extension UIImageView
{
    func load(url: URL)
    {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url)
            {
                if let image = UIImage(data: data)
                {
                    DispatchQueue.main.async
                    {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func makeCircleView()
    {
        DispatchQueue.main.async
        {
            self.layer.cornerRadius = self.frame.size.width/2
            self.clipsToBounds = true
        }
        
    }
}
