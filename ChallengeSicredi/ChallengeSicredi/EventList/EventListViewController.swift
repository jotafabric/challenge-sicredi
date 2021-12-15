//
//  ViewController.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 13/12/21.
//

import UIKit

protocol EventListDisplayLogic: AnyObject {
    func displayEvents(viewModel: [Event])
    func errorLoadingEvents(_ error: String)

}

class EventListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var interactor: EventListBusinessLogic?
    var router: (NSObjectProtocol & EventListRoutingLogic & EventListDataPassing)?
    
    var viewModel: [Event]? {
        didSet{
            setupViewFromViewModel()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewController = self
        let interactor = EventListInteractor()
        let presenter = EventListPresenter()
        let router = EventListRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        interactor.fetchList()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        showLoading()
        
        tableView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.title = "Challenge Sicredi"
    }
    
    func setupViewFromViewModel() {
        tableView.reloadData()
    }
    
    func showLoading(){
        loadingIndicator.isHidden = false
    }
    
    func dismissLoadging(){
        loadingIndicator.isHidden = true
    }
}

extension EventListViewController: EventListDisplayLogic {
    
    func displayEvents(viewModel: [Event]) {
        self.viewModel = viewModel
        tableView.isHidden = false
        dismissLoadging()
    }
    
    func errorLoadingEvents(_ error: String) {
        //view.makeToast(error)
        dismissLoadging()
    }
}

extension EventListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventListTableViewCell", for: indexPath) as? EventListTableViewCell
        
        if let model = viewModel?[indexPath.row]{
            cell?.event = model
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let event = viewModel?[indexPath.row]{
            router?.routeToEventDetail(model: event)
        }
    }
}
