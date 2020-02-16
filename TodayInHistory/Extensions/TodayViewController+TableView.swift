//
//  TodayViewController+TableView.swift
//  TodayInHistory
//
//  Created by mac on 15.02.2020.
//  Copyright © 2020 Alaattin Bedir. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UITableViewDelegate
extension TodayViewController : UITableViewDelegate, UITableViewDataSource, TableViewUpdater {
  
    func updateTableView() {
      tableView.reloadData()      
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:TodayTableViewCell! = tableView.dequeueReusableCell(withIdentifier: todayCellIdentifier) as? TodayTableViewCell
      
        if cell == nil {
          cell = tableView.dequeueReusableCell(withIdentifier: todayCellIdentifier) as? TodayTableViewCell
        }
        
        cell.delegate = self
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let data = displayedData[indexPath.row]
        cell.configureCell(dailyData: data)
        
        return cell
    }
}
