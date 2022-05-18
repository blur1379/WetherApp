//
//  WetherViewModel.swift
//  WetherApp
//
//  Created by Blur on 2/27/1401 AP.
//

import Foundation
import SwiftUI
class WetherViewModel : ObservableObject{
    @Published var wether : WetherModel?
    @Published var statusOfApi : Status = .NONE
    
    @ViewBuilder
    public static func iconForWeather(icon : String) -> some View{
        switch icon {
        case "01d":
            Image(systemName: "sun.max")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.yellow )
                .frame(width: 31, height: 31, alignment: .center)
        case "01n":
            Image(systemName: "moon")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.teal )
                .frame(width: 31, height: 31, alignment: .center)
        case "02d":
            Image(systemName: "cloud.sun")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.teal,.yellow )
                .frame(width: 31, height: 31, alignment: .center)
        case "02n":
            Image(systemName: "cloud.moon")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.teal )
                .frame(width: 31, height: 31, alignment: .center)
        case "03d","03n":
            Image(systemName: "cloud")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.teal )
                .frame(width: 31, height: 31, alignment: .center)
        case "04d","04n":
            Image(systemName: "smoke")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.teal )
                .frame(width: 31, height: 31, alignment: .center)
        case "09d","09n":
            Image(systemName: "cloud.drizzle")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.teal )
                .frame(width: 31, height: 31, alignment: .center)
        case "10d":
            Image(systemName: "cloud.sun.rain")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.teal , .yellow , .teal)
                .frame(width: 31, height: 31, alignment: .center)
        case "10n":
            Image(systemName: "cloud.moon.rain")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.teal )
                .frame(width: 31, height: 31, alignment: .center)
        case "11d","11n":
            Image(systemName: "cloud.bolt")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.teal , .yellow )
                .frame(width: 31, height: 31, alignment: .center)
        case "13d","13n":
            Image(systemName: "snowflake")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.teal )
                .frame(width: 31, height: 31, alignment: .center)
        case "day":
            Image(systemName: "sun.max.circle")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.yellow )
                .frame(width: 31, height: 31, alignment: .center)
        case "max":
            Image(systemName: "thermometer.sun")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.blue , .yellow)
                .frame(width: 31, height: 31, alignment: .center)
        case "min":
            Image(systemName: "thermometer.snowflake")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.blue , .cyan)
                .frame(width: 31, height: 31, alignment: .center)
        case "night":
            Image(systemName: "moon.circle")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.blue)
                .frame(width: 31, height: 31, alignment: .center)
        case "eve":
            Image(systemName: "sunset")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.blue, .yellow)
                .frame(width: 31, height: 31, alignment: .center)
        case "morn":
            Image(systemName: "sunrise")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.blue, .yellow)
                .frame(width: 31, height: 31, alignment: .center)
        default:
            Image(systemName: "")
        }
        
    }
    
    func convertdt(dt : Double)-> String {
            let date = Date(timeIntervalSince1970: dt)
            let dateFormatter = DateFormatter()
//            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
        return localDate
    }

    func fetchWether(lat: Double , lon : Double) {
        statusOfApi = .INPROGRESS
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&units=metric&exclude=hourly,minutely&appid=ac870ee92ead96367b38dc93605b3d6c"
        let urlencoding = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
         guard let url = URL(string: urlencoding ) else {
             fatalError("Missing URL")
             
         }

         let urlRequest = URLRequest(url: url)

         let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
             if let error = error {
                 print("Request error: ", error)
                 self.statusOfApi = .ERROR
                 return
             }

             guard let response = response as? HTTPURLResponse else { return }

             if response.statusCode == 200 {
                 guard let data = data else { return }
                 DispatchQueue.main.async {
                     do {
                         let decodedWeather = try JSONDecoder().decode(WetherModel.self, from: data)
                         self.wether = decodedWeather
                         self.statusOfApi = .SUCSESFULL
                         
                     } catch let error {
                         print("Error decoding: ", error)
                         self.statusOfApi = .ERROR

                     }
                 }
             }else{
                 self.statusOfApi = .ERROR

             }
         }

         dataTask.resume()
     }
}
