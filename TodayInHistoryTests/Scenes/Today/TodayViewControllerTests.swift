//
//  TodayViewControllerTests.swift
//  TodayInHistoryUITests
//
//  Created by mac on 16.02.2020.
//  Copyright © 2020 Alaattin Bedir. All rights reserved.
//

@testable import TodayInHistory
import XCTest

class TodayViewControllerTests: XCTestCase {

    // MARK: - Subject under test
    var sut: TodayViewController!
    var window: UIWindow!
  
    // MARK: - Test lifecycle
    override func setUp() {
      super.setUp()
      window = UIWindow()
      setupTodayViewController()
      
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: - Test setup
    func setupTodayViewController()
    {
      let bundle = Bundle.main
      let storyboard = UIStoryboard(name: "Main", bundle: bundle)
      sut = storyboard.instantiateViewController(withIdentifier: "TodayViewController") as? TodayViewController
    }
    
    func loadView()
    {
      window.addSubview(sut.view)
      RunLoop.current.run(until: Date())
    }
  
    // MARK: - Test doubles
    
    class TodayBusinessLogicSpy: TodayBusinessLogic
    {
      var today: [Today]?
      
      // MARK: Method call expectations
      var fetchTodayCalled = false
      
      
      // MARK: Spied methods
      func fetchTodayInHistory(request: ListToday.FetchToday.Request) {
        fetchTodayCalled = true
      }      
    }
    
    class TableViewSpy: UITableView
    {
      // MARK: Method call expectations
      
      var reloadDataCalled = false
      
      // MARK: Spied methods
      
      override func reloadData()
      {
        reloadDataCalled = true
      }
    }
  
  // MARK: - Tests
  func testShouldFetchOrdersWhenViewDidAppear()
  {
    // Given
    let todayBusinessLogicSpy = TodayBusinessLogicSpy()
    sut.interactor = todayBusinessLogicSpy
    loadView()
    
    // When
    sut.viewDidAppear(true)
    
    // Then
    XCTAssert(todayBusinessLogicSpy.fetchTodayCalled, "Should fetch data after the view appears")
  }
  
  func testNumberOfSectionsInTableViewShouldAlwaysBeOne()
  {
    // Given
    let tableView = sut.tableView
    
    // When
    let numberOfSections = sut.numberOfSections(in: tableView!)
    
    // Then
    XCTAssertEqual(numberOfSections, 1, "The number of table view sections should always be 1")
  }

  func testShouldDisplayFetchedOrders()
  {
    // Given
    let tableViewSpy = TableViewSpy()
    sut.tableView = tableViewSpy
    
    // When
    let event = TodayData(year: "100", text: "100 yil", html: "test", noYearHTML: "test", links: [])
    let displayedEvents = [event]
    
    let birth = TodayData(year: "200", text: "200 yil", html: "test", noYearHTML: "test", links: [])
    let displayedBirth = [birth]
    
    let death = TodayData(year: "300", text: "300 yil", html: "test", noYearHTML: "test", links: [])
    let displayedDeath = [death]
    
    let testViewModel:ListToday.FetchToday.ViewModel = ListToday.FetchToday.ViewModel.init(displayedEvents: displayedEvents, displayedBirths: displayedBirth, displayedDeaths: displayedDeath)
            sut.displayTodayData(viewModel: testViewModel)
    
    // Then
    XCTAssert(tableViewSpy.reloadDataCalled, "Displaying fetched orders should reload the table view")
  }
  
  func testNumberOfRowsInAnySectionShouldEqaulNumberOfOrdersToDisplay()
  {
    // Given
    let tableView = sut.tableView
    
    let event = TodayData(year: "100", text: "100 yil", html: "test", noYearHTML: "test", links: [])
    let displayedEvents = [event]
    
    let birth = TodayData(year: "200", text: "200 yil", html: "test", noYearHTML: "test", links: [])
    let displayedBirth = [birth]
    
    let death = TodayData(year: "300", text: "300 yil", html: "test", noYearHTML: "test", links: [])
    let displayedDeath = [death]
    
    let testDisplayedData:ListToday.FetchToday.ViewModel = ListToday.FetchToday.ViewModel.init(displayedEvents: displayedEvents, displayedBirths: displayedBirth, displayedDeaths: displayedDeath)
    sut.displayedData = testDisplayedData.displayedEvents
    
    // When
    let numberOfRows = sut.tableView(tableView!, numberOfRowsInSection: 0)
    
    // Then
    XCTAssertEqual(numberOfRows, testDisplayedData.displayedEvents.count, "The number of table view rows should equal the number of orders to display")
  }
}
