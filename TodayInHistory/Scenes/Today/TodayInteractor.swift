//
//  TodayInteractor.swift
//  TodayInHistory
//
//  Created by mac on 9.02.2020.
//  Copyright (c) 2020 Alaattin Bedir. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TodayBusinessLogic
{
  func fetchTodayInHistory(request: ListToday.FetchToday.Request)
}

protocol TodayDataStore
{
}

class TodayInteractor: TodayBusinessLogic, TodayDataStore
{
    var presenter: TodayPresentationLogic?
    var todayWorker: TodayWorker?
    var today: Today?
  
    // Interactor is moderator between worker and presenter,
    // In addition it is responsible for business logic
    // It gets request object from viewcontroller and handle network operation regarding this request
    // After that send response to presenter
    func fetchTodayInHistory(request: ListToday.FetchToday.Request)
    {
      todayWorker = TodayWorker()
      todayWorker?.fetchTodayInHistory(completion: { (today, err) in
        self.today = today
        let response = ListToday.FetchToday.Response(today: today)
//        print(response)
        self.presenter?.presentFetchedToday(response: response)
      })
      
    }

}

