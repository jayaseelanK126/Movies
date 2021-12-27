//
//  MoviesResultTableViewController.swift
//  Movie Database App
//
//  Created by Pyramid on 24/12/21.
//

import UIKit

class MoviesResultTableViewController: UITableViewController {
        
    
    
    var filteredProducts = [MoviesModel]()
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

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        if isDashboardList
        {
            loadData()
        }
    }

    func loadData()
    {
        var groupedDictionary = [String : [MoviesModel]]()
        
        switch selectedListValue {
        case CategoryNames.Year:
            groupedDictionary = Dictionary(grouping: (self.filteredProducts), by: {String($0.Year)})
        case CategoryNames.Genre:
            groupedDictionary = Dictionary(grouping: (self.filteredProducts), by: {String($0.Genre)})
        case CategoryNames.Actors:
            groupedDictionary = Dictionary(grouping: (self.filteredProducts), by: {String($0.Actors)})
        case CategoryNames.Directors:
            groupedDictionary = Dictionary(grouping: (self.filteredProducts), by: {String($0.Director)})
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
        return isDashboardList ? sections[section].movies.count : filteredProducts.count
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
        
        let cellData = isDashboardList ? sections[indexPath.section].movies[indexPath.row] : filteredProducts[indexPath.row]
        cell?.titleLbl.text = cellData.Title
        cell?.yearLbl.text = "Year "+cellData.Year
        cell?.durationLbl.text = cellData.Runtime
        cell?.genreLbl.text = cellData.Genre
        cell?.posterImgView.load(url: URL(string:cellData.Poster)!)
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 125
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellData = isDashboardList ? sections[indexPath.section].movies[indexPath.row] : filteredProducts[indexPath.row]
        let nextVc = MoviewDetailViewController()
        nextVc.movieDetails = cellData
        self.navigationController?.pushViewController(nextVc, animated: true)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
