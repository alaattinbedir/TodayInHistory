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
  func doSomething(request: Today.Something.Request)
  func fetchTodayInHistory(request: Today.Something.Request)
}

protocol TodayDataStore
{
  //var name: String { get set }
}

class TodayInteractor: TodayBusinessLogic, TodayDataStore
{
  var presenter: TodayPresentationLogic?
  var worker: TodayWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Today.Something.Request)
  {
    worker = TodayWorker()
    worker?.doSomeWork()
    
    let response = Today.Something.Response()
    presenter?.presentSomething(response: response)
  }
    
    func fetchTodayInHistory(request: Today.Something.Request)
    {
      worker = TodayWorker()
      worker?.fetchTodayInHistory(completion: { (response, err) in
          if let responseData = response{
              print(responseData)
              self.presenter?.presentSomething2(response: responseData)
          }else{
              print("error")
          }
      })
      
      //let response = Today.Something.Response()
      //presenter?.presentSomething(response: response)
    }
    
}
