//
//  ChallengeSicrediTests.swift
//  ChallengeSicrediTests
//
//  Created by Josias Fabrício on 13/12/21.
//

import XCTest
@testable import ChallengeSicredi

class EventListTests: XCTestCase {
    
    var view: EventListMockView?
    var interactor: EventListInteractor?
    var presenter: EventListPresenter?
    var router: EventListRouter?
    var worker: EventWorker?
    
    override func setUp() {
        super.setUp()
        
        view = EventListMockView()
        presenter = EventListPresenter()
        interactor = EventListInteractor()
        router = EventListRouter()
        worker = EventWorker()
        
        presenter?.viewController = view
        presenter?.interactor = interactor
        presenter?.router = router
        
        interactor?.presenter = presenter
    }

    func testFetchEvents() throws {
        let expectation = XCTestExpectation(description: "request")
        worker?.doFetchEvents { list in
            self.presenter?.presentationSuccessFetchList(model: list)
            expectation.fulfill()
        } failure: { error in
            self.presenter?.presentationErrorFetchList(error)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
        
        guard let count = view?.events?.count else {
            XCTFail("func not called")
            return
        }
        
        XCTAssertGreaterThan(count, 0, "fetched")
    }
}

class EventListMockView: EventListDisplayLogic {
    var events: [Event]?
    func displayEvents(viewModel: [Event]) {
        events = viewModel
    }
    
    func errorLoadingEvents(_ error: String) {
        XCTFail("error request: \(error)")
    }
    
}

