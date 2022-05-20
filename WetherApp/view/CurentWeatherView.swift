//
//  CurentWeatherView.swift
//  WetherApp
//
//  Created by Blur on 2/27/1401 AP.
//

import SwiftUI

struct CurentWeatherView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let curentWeather : Current
    let name : String
    var body: some View {
        VStack {
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()

                } label: {
                    Image("back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10.5, height: 19.5, alignment: .center)
                }

               
                Spacer()
                Text (name)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()

                } label: {
                    Image("search")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24, alignment: .center)
                }


                
            }//:HSTACK
            .padding(.horizontal , 26)
            .padding(.top , 48)
            HStack{
                WetherViewModel.iconForWeather(icon: "\(curentWeather.weather.count > 0 ? curentWeather.weather[0].icon : "01d")3d")
                VStack(spacing: 8){
                    Text("Today")
                        .fontWeight(.bold)
                    Text("\(String(format: "%.1f",curentWeather.temp))˚")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(curentWeather.weather.count > 0 ? curentWeather.weather[0].description : "clear")
                        .opacity(0.5)
                }//:VSTACK
                
            }//:HSTACK
            
            RoundedRectangle(cornerRadius: 2)
                .frame(height: 2)
                .padding(.horizontal,37)
                .foregroundColor(Color("Divaider"))
            Spacer()
            HStack{
                VStack(alignment: .center, spacing: 8) {
                    Image("Wind")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 15, alignment: .center)
                    Text("\(String(format: "%.0f", curentWeather.wind_speed)) km/h")
                    
                    Text("wind")
                        .opacity(0.5)
                }//:VSTACK
                Spacer()
                VStack(alignment: .center, spacing: 8) {
                    Image("Humidity")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20, alignment: .center)
                    Text("\(String(format: "%.0f", curentWeather.humidity)) %")
                    
                    Text("humidity")
                        .opacity(0.5)
                }//:VSTACK
                Spacer()
                VStack(alignment: .center, spacing: 8) {
                    Image("Rainy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24, alignment: .center)
                    Text("\(String(format: "%.0f", curentWeather.clouds)) %")
                    
                    Text("clouds")
                        .opacity(0.5)
                }//:VSTACK
            }//:HSTACK
            .padding(.horizontal, 50)
            Spacer()
        }//:VSTACK
        .background{
            RoundedRectangle(cornerRadius: 40)
            
                .fill(LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(#colorLiteral(red: 0.8039215803146362, green: 0.8039215803146362, blue: 0.8039215803146362, alpha: 1)), location: 0),
                        .init(color: Color(#colorLiteral(red: 0.9490196108818054, green: 0.9490196108818054, blue: 0.9490196108818054, alpha: 1)), location: 1)]),
                    startPoint: UnitPoint(x: 0.9999999701976785, y: -3.329098030580013e-8),
                    endPoint: UnitPoint(x: 0, y: 0.9999999369066982)))
                .frame(width: UIScreen.main.bounds.width, height: 371.1)
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.20000000298023224)), radius:4, x:2, y:2)
            
        }
        .frame(width: UIScreen.main.bounds.width, height: 371.1)
        
    }
}

struct CurentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurentWeatherView(curentWeather: Current(temp: 24, humidity: 32, wind_speed: 12, clouds: 12, weather: [Weather(id: 801, main: "Clouds", description: "overcast clouds", icon: "01d")]), name: "London")
    }
}
