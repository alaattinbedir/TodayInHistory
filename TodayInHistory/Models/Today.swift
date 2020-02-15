//
//  Today.swift
//  TodayInHistory
//
//  Created by mac on 15.02.2020.
//  Copyright © 2020 Alaattin Bedir. All rights reserved.
//

import Foundation

// MARK: - Today
struct Today: Codable {
    let date: String
    let url: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let events, births, deaths: [Birth]

    enum CodingKeys: String, CodingKey {
        case events = "Events"
        case births = "Births"
        case deaths = "Deaths"
    }
}

// MARK: - Birth
struct Birth: Codable {
    let year, text, html, noYearHTML: String
    let links: [Link]

    enum CodingKeys: String, CodingKey {
        case year, text, html
        case noYearHTML = "no_year_html"
        case links
    }
}

// MARK: - Link
struct Link: Codable {
    let title: String
    let link: String
}
