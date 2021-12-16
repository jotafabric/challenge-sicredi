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
    
    var presenter: (NSObjectProtocol & EventDetailPresantationLogic & EventDetailDataPassing)?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.presentationStarFlow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
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
        
        viewController.presenter = presenter
        
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.dataStore = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = viewController
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
        
        presenter?.presentationGetAddress()
    }
    
    func setupViewModelAddress(){
        addressLabel.text = viewModelAddress
    }
    
    @IBAction func tapCheckinButton(_ sender: Any) {
        presenter?.presentationRouteToEventCheckin(eventId: viewModel!.eventId)
    }
    
    @objc func tapShareBarItem(){
        let items = [titleLabel.text!, addressLabel.text!, dateLabel.text!]
        presenter?.presentationRouteToShareEvent(items: items)
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
