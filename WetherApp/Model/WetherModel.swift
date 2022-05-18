//
//  Wether.swift
//  WetherApp
//
//  Created by Blur on 2/24/1401 AP.
//

import Foundation
struct WetherModel : Codable{
    let current : Current
    let daily : [Daily]
}

struct Current : Codable {
    let temp : Double
    let humidity : Double
    let wind_speed : Double
    let clouds : Double
    let weather : [Weather]
}
struct Daily : Codable {
    let dt : Double
    let temp : Temp
    let humidity : Double
    let wind_speed : Double
    let dew_point : Double
    let clouds : Double
    let weather : [Weather]
}
struct Weather : Codable , Identifiable{
    let id : Int
    let main : String
    let description : String
    let icon : String
}
struct Temp : Codable {
    let day : Double
    let min : Double
    let max : Double
    let night : Double
    let eve : Double
    let morn : Double
}
