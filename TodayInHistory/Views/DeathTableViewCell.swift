//
//  TodayTableViewCell.swift
//  TodayInHistory
//
//  Created by mac on 15.02.2020.
//  Copyright © 2020 Alaattin Bedir. All rights reserved.
//

import UIKit
import WebKit


class DeathTableViewCell: BaseTableViewCell {

  @IBOutlet weak var dataYearLabel: UILabel!
  @IBOutlet weak var dataTextLabel: UILabel!
  @IBOutlet weak var dataHtmlWebView: WKWebView!
  @IBOutlet weak var webViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        
        dataTextLabel.adjustsFontSizeToFitWidth = true
        dataTextLabel.sizeToFit()
    
        dataHtmlWebView.navigationDelegate = self
        dataHtmlWebView.translatesAutoresizingMaskIntoConstraints = false
        dataHtmlWebView.scrollView.isScrollEnabled = false
        dataHtmlWebView.scrollView.bounces = false
        
        loadingActivityIndicator.isHidden = false
        loadingActivityIndicator.hidesWhenStopped = true
        loadingActivityIndicator.startAnimating()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
  
  override func loadHTMLContent(_ htmlContent: String) {
      let htmlStart = "<HTML><HEAD><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, shrink-to-fit=no\"></HEAD><BODY>"
      let htmlEnd = "</BODY></HTML>"
      let htmlString = "\(htmlStart)\(htmlContent)\(htmlEnd)"
      dataHtmlWebView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
  }
  
  override func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
      if complete != nil {
            webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (height, error) in
            self.webViewHeightConstraint?.constant = height as! CGFloat
//            print("Height: \(height ?? 0)")
              DispatchQueue.main.async {
                  self.loadingActivityIndicator.stopAnimating()
              }
            super.updateTableView()
        })
    }
    })
  }
  
  func configureCell(dailyData: TodayData) {
    dataYearLabel.text = dailyData.year
    dataTextLabel.text = dailyData.text
    loadHTMLContent(dailyData.noYearHTML)
  }
  
}
