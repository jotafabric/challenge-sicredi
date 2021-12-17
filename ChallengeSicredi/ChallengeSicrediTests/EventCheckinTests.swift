//
//  EventCheckInTests.swift
//  ChallengeSicrediTests
//
//  Created by Josias Fabrício on 17/12/21.
//

import XCTest
@testable import ChallengeSicredi

class EventCheckinTests: XCTestCase {
    
    var view: EventCheckinMockView?
    var presenter: EventCheckinPresenter?
    var router: EventCheckinRouter?
    var interactor: EventCheckinInteractor?
    var worker: EventCheckinWorker?
    
    override func setUp() {
        super.setUp()
        
        view = EventCheckinMockView()
        presenter = EventCheckinPresenter()
        router = EventCheckinRouter()
        interactor = EventCheckinInteractor()
        worker = EventCheckinWorker()
        
        presenter?.viewController = view
        presenter?.interactor = interactor
        presenter?.router = router
    
        interactor?.presenter = presenter
    }
    
    func testDoCheckin() throws {
        let expectation = XCTestExpectation(description: "request")
        
        var mockModel: EventCheckinModel.ViewModel = EventCheckinModel.ViewModel(eventId: "1")
        mockModel.personName = "Person Name"
        mockModel.personEmail = "email@email.com"
        
        worker?.doPostCheckin(mockModel) { response in
            self.presenter?.presentCheckinSucces()
            expectation.fulfill()
        } failure: { error in
            self.presenter?.presentCheckinFailure()
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        guard let success = view?.checkInSuccess else {
            XCTFail("func not called")
            return
        }
        
        XCTAssertTrue(success)
    }
    
}

class EventCheckinMockView: EventCheckinDisplayLogic {
    var checkInSuccess: Bool?
    
    func displayEventIdViewModel(_ eventId: String) {}
    
    func displayEventCheckinSuccess() {
        checkInSuccess = true
    }
    
    func displayEventCheckInFailure() {
        checkInSuccess = false
    }
    
    func displayValueFieldsValid() {}
    
    func displayValueFieldsInvalid() {}
}

