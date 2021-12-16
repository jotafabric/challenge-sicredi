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
    
    var presenter: (NSObjectProtocol & EventCheckinPresentationLogic & EventCheckinDataPassing)?
    var model: EventCheckinModel.ViewModel?
    
    var eventId: String? {
        didSet {
            setupViewModelEventId()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.presentationStarFlow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTextFields()
    }
    
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
        
        viewController.presenter = presenter
        
        presenter.viewController = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.dataStore = interactor
        
        interactor.presenter = presenter

        router.viewController = viewController
    }
    
    private func setupViewModelEventId() {
        model = EventCheckinModel.ViewModel(eventId: eventId!)
    }
    
    @IBAction func tapCheckinButton(_ sender: Any) {
        model?.personName = nameText.text!
        model?.personEmail = emailText.text!
        
        presenter?.presentationDoCheckin(model: model!)
    }
    
    func setupTextFields() {
        nameText.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        emailText.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        checkinButton.isEnabled = false
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        presenter?.presentationValidateFields(name: nameText.text!, email: emailText.text!)
    }
}

extension EventCheckinViewController: EventCheckinDisplayLogic {
    
    func displayEventIdViewModel(_ eventId: String){
        self.eventId = eventId
    }
    
    func displayEventCheckinSuccess() {
        presenter?.presentationRouteToCheckinSuccess()
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
