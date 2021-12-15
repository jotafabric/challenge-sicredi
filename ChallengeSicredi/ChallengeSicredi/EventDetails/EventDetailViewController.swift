//
//  EventDetailViewController.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 14/12/21.
//

import Foundation
import UIKit
import Kingfisher

protocol EventDetailDisplayLogic: AnyObject {
    func displayEventDetails(viewModel: EventDetailModels.ViewModel)
    func displayAddress(_ address: String)
    func displayNoAddress()
}

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var interactor: EventDetailBusinessLogic?
    var router: (NSObjectProtocol & EventDetailRoutingLogic & EventDetailDataPassing)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.startFlow()
        setupView()
    }
    
    var viewModel: EventDetailModels.ViewModel?{
        didSet{
            setupViewModel()
        }
    }
    
    var viewModelAddress: String? {
        didSet {
            setupViewModelAddress()
        }
    }
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        let viewController = self
        let interactor = EventDetailInteractor()
        let presenter = EventDetailPresenter()
        let router = EventDetailRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.tintColor
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        navigationItem.titleView = label
        
        return label
    }()
    
    func setupView(){
        let shareBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(tapShareBarItem))
        self.navigationItem.rightBarButtonItem  = shareBarButtonItem
    }
    
    func setupViewModel() {
        titleLabel.text = viewModel?.title
        descriptionText.text = viewModel?.description
        dateLabel.text = "Quando: \(viewModel?.date ?? "")"
        priceLabel.text = viewModel?.price
        
        image.kf.setImage(with: URL(string: viewModel!.imageUrl), placeholder: UIImage(named: "eventImageDefault"), options: nil, progressBlock: nil, completionHandler: nil)
        
        interactor?.getAddress()
    }
    
    func setupViewModelAddress(){
        addressLabel.text = viewModelAddress
    }
    
    @IBAction func tapCheckinButton(_ sender: Any) {
        router?.routeToEventCheckin(eventId: viewModel!.eventId)
    }
    
    @objc func tapShareBarItem(){
        router?.routeToShareEvent(title: titleLabel.text!, address: addressLabel.text!, date: dateLabel.text!)
    }
    
}

extension EventDetailViewController: EventDetailDisplayLogic {
    
    func displayNoAddress() {
        self.viewModelAddress = "Onde: N/A"
    }
    
    func displayAddress(_ address: String) {
        self.viewModelAddress = "Onde: \(address)"
    }
    
    func displayEventDetails(viewModel: EventDetailModels.ViewModel) {
        self.viewModel = viewModel
    }
}
