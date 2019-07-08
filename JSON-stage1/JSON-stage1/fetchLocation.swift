//
//  fetchLocation.swift
//  JSON-stage1
//
//  Created by yunweichen on 7/7/19.
//  Copyright © 2019 yunweichen. All rights reserved.
//

import Foundation
struct fetchLocation: Codable{
    var title: String
    var woeid: Int
    var latt_long: String
}

struct Detail: Decodable{
    var consolidated_weather:[Consolidated]
}
struct  Consolidated: Codable{
    var id: Int
    var weather_state_name: String
    var created: String

}
