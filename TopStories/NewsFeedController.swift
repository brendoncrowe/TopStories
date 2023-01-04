//
//  ViewController.swift
//  TopStories
//
//  Created by Brendon Crowe on 1/2/23.
//

import UIKit

enum SearchScope {
    case title, abstract
}

class NewsFeedController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    var headlines = [NewsHeadline]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var currentScope = SearchScope.title // default value is 0 "Title"
    
    // when searchQuery observes a change, which is text input from the searchBar, the didSet runs, and the switch control case corresponding to the currentScope value (0: Title or 1: Abstract) runs
    
    var searchQuery = "" {
        didSet {
            switch currentScope {
            case .title:
                headlines = HeadlinesData.getHeadlines().filter { $0.title.lowercased().contains(searchQuery.lowercased())}
            case .abstract:
                headlines = HeadlinesData.getHeadlines().filter { $0.abstract.lowercased().contains(searchQuery.lowercased())}
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchBar()
        loadData()
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.showsScopeBar = false
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func loadData() {
        headlines = HeadlinesData.getHeadlines()
    }
    
    // helper function used to filter through headlines, which is = to array [NewsHeadline]
    // if there is no text, return exits the function
//    func filterHeadlines(by searchText: String) {
//        guard !searchText.isEmpty else { return }
//        headlines = HeadlinesData.getHeadlines().filter { $0.title.lowercased().contains(searchText.lowercased()) }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailView, let indexPath = tableView.indexPathForSelectedRow else { fatalError("could not load detail view controller")}
        detailVC.headline = headlines[indexPath.row]
    }
}

extension NewsFeedController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "headlineCell", for: indexPath) as? HeadlineCell else { fatalError("could not dequeue a HeadlineCell")}
        let headline = headlines[indexPath.row]
        cell.configureCell(for: headline)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsScopeBar = true
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            // if search text is empty here, original headlines are presented using loadData() method
            loadData()
            return
        }
        searchQuery = searchText
//        filterHeadlines(by: searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsScopeBar = false
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentScope = .title
        case 1:
            currentScope = .abstract
        default:
            print("not a valid search scope")
        }
    }
}
