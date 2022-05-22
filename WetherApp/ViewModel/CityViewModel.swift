//
//  CityViewModel.swift
//  WetherApp
//
//  Created by Blur on 2/24/1401 AP.
//

import SwiftUI
import Combine
class CityViewModel : ObservableObject{
    @Published var city : [CityModel] = []
    @Published var statusOfApi : Status = .NONE
    func fetchCity(cityName : String) {
        city = []
        
        statusOfApi = .INPROGRESS
        let urlString = "http://api.openweathermap.org/geo/1.0/direct?q=\(cityName)&limit=7&appid=ac870ee92ead96367b38dc93605b3d6c"
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
                         let decodedCity = try JSONDecoder().decode([CityModel].self, from: data)
                         self.city = decodedCity
                         self.statusOfApi = .SUCSESFULL
                         
                     } catch let error {
                         print("Error decoding: ", error)
                         self.statusOfApi = .SUCSESFULL
                         
                         
                     }
                 }
             }else{
                 self.statusOfApi = .ERROR

             }
         }

         dataTask.resume()
     }
}
