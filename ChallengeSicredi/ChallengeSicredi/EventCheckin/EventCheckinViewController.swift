//
//  EventCheckinViewController.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 14/12/21.
//

import Foundation
import UIKit

protocol EventCheckinDisplayLogic: AnyObject {
    func displayEventIdViewModel(_ eventId: String)
    func displayEventCheckinSuccess()
    func displayEventCheckInFailure()
    func displayValueFieldsValid()
    func displayValueFieldsInvalid()
}

class EventCheckinViewController: UIViewController{
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var checkinButton: UIButton!
    
    var interactor: EventCheckinBusinessLogic?
    var router: (NSObjectProtocol & EventCheckinRoutingLogic & EventCheckinDataPassing)?
    
    var model: EventCheckinModel.ViewModel?
    
    var eventId: String? {
        didSet {
            setupViewModelEventId()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.startFlow()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupTextFields()
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
    
    private func setup() {
        let viewController = self
        let interactor = EventCheckinInteractor()
        let presenter = EventCheckinPresenter()
        let router = EventCheckinRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupViewModelEventId() {
        model = EventCheckinModel.ViewModel(eventId: eventId!)
    }
    
    @IBAction func tapCheckinButton(_ sender: Any) {
        model?.personName = nameText.text!
        model?.personEmail = emailText.text!

        interactor?.doPostCheckin(model: model!)
    }
    
    func setupTextFields() {
        nameText.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        emailText.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        checkinButton.isEnabled = false
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        interactor?.validateFields(name: nameText.text!, email: emailText.text!)
    }
}

extension EventCheckinViewController: EventCheckinDisplayLogic {
    
    func displayEventIdViewModel(_ eventId: String){
        self.eventId = eventId
    }
    
    func displayEventCheckinSuccess() {
        self.router?.routeToSuccessCheckin()
    }
    
    func displayEventCheckInFailure() {
        
    }
    
    func displayValueFieldsValid() {
        checkinButton.isEnabled = true
    }
    
    func displayValueFieldsInvalid() {
        checkinButton.isEnabled = false
    }
}
