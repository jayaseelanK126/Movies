//
//  ViewController.swift
//  Movie Database App
//
//  Created by Pyramid on 26/12/21.
//

import UIKit

class ViewController: UIViewController, UISearchControllerDelegate {
  
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    /// Search controller to help us with filtering.
    var searchController: UISearchController!
    
    /// Data model for the table view.
    var category = [Category]()
    var movies = [MoviesModel]()

    /// The search results table view.
    var resultsTableController: MoviesResultTableViewController!
    
    /// cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "Cell"
    

    lazy var viewModelObj:ViewModel =
    {
        return ViewModel()
    }()
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    func setUp()
    {
        resultsTableController = MoviesResultTableViewController()
        resultsTableController.suggestedSearchDelegate = self
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.searchTextField.placeholder = NSLocalizedString("Search moviews by title/genre/director", comment: "")
        searchController.searchBar.returnKeyType = .done

        // Place the search bar in the navigation bar.
        navigationItem.searchController = searchController
        // Make the search bar always visible.
        navigationItem.hidesSearchBarWhenScrolling = false
     
        // Monitor when the search controller is presented and dismissed.
        searchController.delegate = self

        // Monitor when the search button is tapped, and start/end editing.
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        
        //Tableview register cell
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        category = [Category(name: CategoryNames.Year), Category(name: CategoryNames.Genre), Category(name: CategoryNames.Directors), Category(name: CategoryNames.Actors)]
        
        //load Data
        loadData()
        
        tableView.reloadData()
    }

    func loadData()
    {
        if let safeData = viewModelObj.loadJson(filename: "movies")
        {
            movies = safeData
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)! as UITableViewCell
        cell.textLabel?.text = category[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextVc = MoviesResultTableViewController()
        nextVc.selectedListValue = category[indexPath.row].name
        nextVc.filteredMovies = movies
        nextVc.isDashboardList = true
        self.navigationController?.pushViewController(nextVc, animated: true)

    }
    
    func setToSuggestedSearches() {
        // Show suggested searches only if we don't have a search token in the search field.
        if searchController.searchBar.searchTextField.tokens.isEmpty {
            resultsTableController.showSuggestedSearches = true
            
            resultsTableController.tableView.delegate = resultsTableController
        }
    }
}

// MARK: - UISearchBarDelegate

extension ViewController: UISearchBarDelegate {
    
    // present the search controller, so from the start - show suggested searches.
    func presentSearchController(_ searchController: UISearchController) {
        searchController.showsSearchResultsController = true
            setToSuggestedSearches()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.isEmpty {
            // Text is empty, show suggested searches again.
            setToSuggestedSearches()
        } else {
            resultsTableController.showSuggestedSearches = false
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // User tapped the Done button in the keyboard.
        searchController.dismiss(animated: true, completion: nil)
        searchBar.text = ""
    }

}

extension ViewController: UISearchResultsUpdating
{
    // Called when the search bar's text has changed or when the search bar becomes first responder.
    func updateSearchResults(for searchController: UISearchController)
    {
        // Update the MoviewResultsController's filtered moview items based on the search terms and suggested search token.
        let searchResults = movies

        // Strip out all the leading and trailing spaces.
        let whitespaceCharacterSet = CharacterSet.whitespaces
        let strippedString = searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet).lowercased()
        let searchItems = strippedString.components(separatedBy: " ") as [String]
        
        
        // Filter results down by title, Genre and Actors and Director.
        var filtered = searchResults
        var curTerm = searchItems[0]
        var idx = 0
        while curTerm != "" {
            filtered = filtered.filter {
                $0.Title.lowercased().contains(curTerm) ||
                $0.Genre.description.lowercased().contains(curTerm) ||
                $0.Actors.description.lowercased().contains(curTerm) ||
                $0.Director.description.lowercased().contains(curTerm)
            }
            idx += 1
            curTerm = (idx < searchItems.count) ? searchItems[idx] : ""
        }
        
        // Apply the filtered results to the search results table.
        if let resultsController = searchController.searchResultsController as? MoviesResultTableViewController {
            resultsController.filteredMovies = filtered
            resultsController.tableView.reloadData()
        }
    }
}

extension ViewController: SuggestedSearch {
    
    func didSelectMovie(_ movie: MoviesModel)
    {
        let nextVc = MoviewDetailViewController()
        nextVc.movieDetails = movie
        navigationController?.pushViewController(nextVc, animated: true)

    }
}
