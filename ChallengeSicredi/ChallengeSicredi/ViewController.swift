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

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: EventListBusinessLogic?
    
    var viewModel: [Event]? {
        didSet{
            setupViewFromViewModel()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let viewController = self
        let interactor = EventListInteractor()
        let presenter = EventListPresenter()
        //let router = EventListRouter()
        
        viewController.interactor = interactor
        //viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        //router.viewController = viewController
        //router.dataStore = interactor
        
        interactor.fetchList()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupViewFromViewModel() {
        tableView.reloadData()
    }


}

extension ViewController: EventListDisplayLogic {
    func displayEvents(viewModel: [Event]) {
        self.viewModel = viewModel
        //dismissLoading()
    }
    
    func errorLoadingEvents(_ error: String) {
        //view.makeToast(error)
        //dismissLoading()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
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
}

