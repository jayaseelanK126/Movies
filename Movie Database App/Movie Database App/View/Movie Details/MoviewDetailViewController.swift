//
//  MoviewDetailViewController.swift
//  Movie Database App
//
//  Created by Pyramid on 26/12/21.
//

import UIKit

class MoviewDetailViewController: UIViewController {
    
    @IBOutlet weak var posterImgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var castAndCrewLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var plotLbl: UILabel!
    @IBOutlet weak var userRatingBtn: UIButton!
    
    //MARK: Properties
    var movieDetails:MoviesModel?
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
    }
    
    //MARK: - Load/Map data
    func loadData()
    {
        DispatchQueue.main.async {
            self.userRatingBtn.layer.cornerRadius = 10.0
            if let safeData = self.movieDetails?.Poster
            {
                self.posterImgView.load(url: URL(string: safeData)!)
            }
            self.titleLbl.text = self.movieDetails?.Title ?? "--"
            self.castAndCrewLbl.text = (self.movieDetails?.Actors ?? "") + (self.movieDetails?.Director ?? "")
            self.releaseDateLbl.text = self.movieDetails?.Released ?? "--"
            self.genreLbl.text = self.movieDetails?.Genre ?? "--"
            self.plotLbl.text = self.movieDetails?.Plot ?? "--"
        }
        
    }
    //MARK: - Ratings Button Action
    @IBAction func userRatingBtnAction(_ sender: Any)
    {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
}

//MARK: - PickerView Delegate
extension MoviewDetailViewController:UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return movieDetails?.Ratings.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let ratingSource = movieDetails?.Ratings[row].Source
        let value = movieDetails?.Ratings[row].Value
        return "\(ratingSource ?? "--") - \(value ?? "--")"
        }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
            self.view.endEditing(true)
        }
    
}
