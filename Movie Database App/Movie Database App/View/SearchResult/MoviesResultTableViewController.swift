//
//  MoviesResultTableViewController.swift
//  Movie Database App
//
//  Created by Pyramid on 26/12/21.
//

import UIKit

class MoviesResultTableViewController: UITableViewController {
        
    
    //MARK: Properties
    ///This properties used for both seach results and list based on category like year/actors
    var filteredMovies = [MoviesModel]()
    var sections = [Section]()
    var isDashboardList:Bool = false
    var selectedListValue:String = ""
    
    var showSuggestedSearches: Bool = false {
        didSet {
            if oldValue != showSuggestedSearches {
                tableView.reloadData()
            }
        }
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        if isDashboardList
        {
            loadData()
        }
    }

    //MARK: - Load/Setup Data
    func loadData()
    {
        var groupedDictionary = [String : [MoviesModel]]()
        
        switch selectedListValue {
        case CategoryNames.Year:
            groupedDictionary = Dictionary(grouping: (self.filteredMovies), by: {String($0.Year)})
        case CategoryNames.Genre:
            groupedDictionary = Dictionary(grouping: (self.filteredMovies), by: {String($0.Genre)})
        case CategoryNames.Actors:
            groupedDictionary = Dictionary(grouping: (self.filteredMovies), by: {String($0.Actors)})
        case CategoryNames.Directors:
            groupedDictionary = Dictionary(grouping: (self.filteredMovies), by: {String($0.Director)})
        default:
            break
        }
        
        let keys = groupedDictionary.keys.sorted()
         
        self.sections = keys.map {Section(letter: $0, movies: groupedDictionary[$0]!)}
        
        print(self.sections)
        
        DispatchQueue.main.async {
            UITableViewHeaderFooterView.appearance().tintColor = .lightGray
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return isDashboardList ? sections.count : 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return isDashboardList ? sections[section].movies.count : filteredMovies.count
    }
    
    override func tableView(_ tableView:UITableView, titleForHeaderInSection  section: Int) -> String?
    {
        return isDashboardList ? sections[section].letter : nil
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryOptionTableViewCell
        
        if cell == nil
        {
            let topLevelObjects = Bundle.main.loadNibNamed("CategoryOptionTableViewCell", owner: self, options: nil)
            cell = topLevelObjects?[0] as? CategoryOptionTableViewCell
        }
        
        let cellData = isDashboardList ? sections[indexPath.section].movies[indexPath.row] : filteredMovies[indexPath.row]
        cell?.titleLbl.text = cellData.Title
        cell?.yearLbl.text = "Year "+cellData.Year
        cell?.durationLbl.text = cellData.Runtime
        cell?.genreLbl.text = cellData.Genre
        cell?.posterImgView.load(url: URL(string:cellData.Poster)!)
        
        return cell!
    }
    
    //MARK: Tableview Delegates
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 125
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellData = isDashboardList ? sections[indexPath.section].movies[indexPath.row] : filteredMovies[indexPath.row]
        let nextVc = MoviewDetailViewController()
        nextVc.movieDetails = cellData
        self.navigationController?.pushViewController(nextVc, animated: true)
    }
   
}
