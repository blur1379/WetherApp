//
//  Home.swift
//  WetherApp
//
//  Created by Blur on 2/22/1401 AP.
//

import SwiftUI

struct Home: View {
    //MARK: -PEROPERTIES
    @ObservedObject var weather : WetherViewModel = WetherViewModel()
    let lat : Double
    let lon : Double
    let name : String
    @ViewBuilder
    func itemForWether(dayWether : [Daily]) -> some View{
        ScrollView{
            ForEach(dayWether , id: \.dt) { item in
                NavigationLink {
                    DailyView(name: name, dailyWeather: item, date: weather.convertdt(dt: item.dt))
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack{
                        Text(weather.convertdt(dt: item.dt))
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .font(.title3)
                        Spacer()
                        HStack{
                            WetherViewModel.iconForWeather(icon: item.weather.count > 0 ? item.weather[0].icon : "01d")
                            
                            Text(item.weather.count > 0 ? item.weather[0].main : "clear" )
                                .foregroundColor(.black)
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .font(.title3)
                        }//:HSTACK
                        Spacer()
                        Text("\(String(format:"%.0f",item.temp.max))")
                            .foregroundColor(.black)
                            .font(.system(size: 12))
                        Text("\(String(format:"%.0f",item.temp.min))")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .opacity(0.5)
                        
                    }//:HSTACK
                    .padding(.horizontal , 33)
                    .padding(.vertical)

                }

            }//LOOP
        }//:SCROLL
        
    }
    
  
    //MARK: -BODY
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            CurentWeatherView(curentWeather: weather.wether?.current ?? Current(temp: 0, humidity: 0, wind_speed: 0, clouds: 0, weather: []), name: name)
                .background(Color.clear)
            
            switch weather.statusOfApi {
            case .SUCSESFULL :
                itemForWether(dayWether: weather.wether?.daily ?? [])
            case .ERROR :
                Spacer()
                Button {
                    self.weather.fetchWether(lat: lat, lon: lon)
                } label: {
                    Text("Try again")
                        .fontWeight(.bold)
                        .foregroundColor(Color.red)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(16)
                }
                Spacer()
            case .INPROGRESS :
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            default:
               Spacer()
            }
            
        }
        .onAppear{
            self.weather.fetchWether(lat: lat, lon: lon)
        }
        .ignoresSafeArea()
        
        
    }
}
//MARK: -PREVIEW
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(lat: 0.00, lon: 0.00, name: "London")
        
        
        
    }
}
