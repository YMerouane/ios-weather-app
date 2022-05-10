//
//  SearchViewController.swift
//  iOSWeather
//
//  Created by MEROUANE Yassine.

import UIKit
import SnapKit
import CoreLocation

protocol SearchDisplayLogic: AnyObject {
    func displayCities(viewModel: Search.ViewModels.ViewModel)
    func displayError(message: String)
}

class SearchViewController: UIViewController, SearchDisplayLogic {
    
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    
    private var viewModel = Search.ViewModels.ViewModel()
    private var searchController: UISearchController!
    private var tableView: UITableView!
    private let activityIndicator: UIActivityIndicatorView = {
        $0.color = .white
        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView())
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    // MARK: View lifecycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.blur(style: .regular)
        setupSearchController(placeholder: "Search Cities")
        setupNavigationController(title: "Search Cities")
        setupTableView()
        activateConstraints()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    // MARK: Search Cities
    
    //@IBOutlet weak var nameTextField: UITextField!
    func searchCities(name: String) {
        interactor?.searchCities(name: name)
        activityIndicator.startAnimating()
    }
    //MARK: SearchDisplayLogic
    func displayCities(viewModel: Search.ViewModels.ViewModel) {
      DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.viewModel = viewModel
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    func displayError(message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.router?.showAlert(message: message)
            self.activityIndicator.stopAnimating()
        }
      
    }
    
    //MARK: Initial setup
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(PlaceCell.self,
                           forCellReuseIdentifier: PlaceCell.description())
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func setupSearchController(placeholder: String) {
        self.searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.tintColor = .white
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = placeholder
    }
    
    private func setupNavigationController(title: String) {
        navigationItem.searchController = searchController
        navigationController?.hidesBarsOnSwipe = false
        navigationItem.title = title
        let activity = UIBarButtonItem(customView: activityIndicator)
        navigationItem.rightBarButtonItem = activity
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.barTintColor = .darkGray.withAlphaComponent(0.3)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    //MARK: Constraints
    private func activateConstraints() {
        view.addMultipleSubviews(
            tableView
        )
        //table view
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        
    }
    
}
//MARK: UISearchResultsUpdating delegate

extension SearchViewController: UISearchResultsUpdating  {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        guard !text.isEmpty else {
            return
        }
        searchCities(name: text)
        
    }
    
}

//MARK: UITableViewDataSource
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceCell.description(), for: indexPath) as! PlaceCell
        cell.viewModel = viewModel.item(at: indexPath.row)
        return cell
    }
    
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewModel.itemViewModel(at: indexPath)
        let coord = Coord(lat: viewModel.latitude, lon: viewModel.longitude)
        router?.routeToHome(with: viewModel.name, and: coord)
        
    }
    
    
}
