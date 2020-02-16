//
//  BaseTableViewCell.swift
//  TodayInHistory
//
//  Created by mac on 16.02.2020.
//  Copyright © 2020 Alaattin Bedir. All rights reserved.
//

import UIKit
import WebKit

protocol TableViewUpdater: class {
    func updateTableView()
}

class BaseTableViewCell: UITableViewCell,WKNavigationDelegate {

    weak var delegate: TableViewUpdater?
  
    override func awakeFromNib() {
        super.awakeFromNib()        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
  
    func loadHTMLContent(_ htmlContent: String) {
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
  
    func updateTableView() {
      self.delegate?.updateTableView()
    }
    
}
