//
//  EventDetailTest.swift
//  ChallengeSicrediTests
//
//  Created by Josias Fabrício on 17/12/21.
//

import XCTest
@testable import ChallengeSicredi

class EventDetailTests: XCTestCase {
    
    var view: EventDetailMockView?
    var presenter: EventDetailPresenter?
    var router: EventDetailRouter?
    var interactor: EventDetailInteractor?
    var worker: EventDetailWorker?
    
    override func setUp() {
        super.setUp()
        
        view = EventDetailMockView()
        presenter = EventDetailPresenter()
        router = EventDetailRouter()
        interactor = EventDetailInteractor()
        worker = EventDetailWorker()
        
        presenter?.viewController = view
        presenter?.interactor = interactor
        presenter?.router = router
    
        interactor?.presenter = presenter
    }
    
    func testGetAddress() throws {
        let expectation = XCTestExpectation(description: "request")
        
        worker?.getAddress(lat: -30.037878, long: -51.2148497) { address in
            self.presenter?.presentationSuccessGetAddress(address)
            expectation.fulfill()
        } failure: {
            self.presenter?.presentationFailureGetAddress()
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        guard let address = view?.address else {
            XCTFail("func not called")
            return
        }
        
        XCTAssertNotNil(address)
    }
    
}

class EventDetailMockView: EventDetailDisplayLogic {
    var address: String?
    func displayEventDetails(viewModel: EventDetailModels.ViewModel) {}
    
    func displayAddress(_ address: String) {
        self.address = address
    }
    
    func displayNoAddress() {
        XCTFail("error request: no address")
    }
}
