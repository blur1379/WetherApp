//
//  DailyView.swift
//  WetherApp
//
//  Created by Blur on 2/28/1401 AP.
//

import SwiftUI

struct DailyView: View {
    //MARK: -PEROPERTIES
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let name : String
    let dailyWeather : Daily
    let date : String
    
    
    //MARK: -VIEWBUILDER
    @ViewBuilder
    func itemDay(title : String , temp : Double) -> some View {
        VStack(spacing: 0){
            Text("\(String(format: "%.0f",temp))˚")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom , 8)
            WetherViewModel.iconForWeather(icon: title)
            Text(title)
                .opacity(0.5)
        }
        .padding()
        .background{
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient(
                        gradient: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0.9333333373069763, green: 0.9333333373069763, blue: 0.9333333373069763, alpha: 1)), location: 0),
                    .init(color: Color(#colorLiteral(red: 0.9843137264251709, green: 0.9843137264251709, blue: 0.9843137264251709, alpha: 1)), location: 1)]),
                        startPoint: UnitPoint(x: -2.6645352591003757e-15, y: -2.6645352591003757e-15),
                        endPoint: UnitPoint(x: 0.9489795505676157, y: 0.961206913975531)))

                RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.07999999821186066)), lineWidth: 1)
            }
            .compositingGroup()
            .frame(width: 98)
//            .frame(maxHeight: .infinity , alignment: .center)
            .shadow(color: Color(#colorLiteral(red: 0.8666666746139526, green: 0.8666666746139526, blue: 0.8666666746139526, alpha: 1)), radius:4, x:2, y:2)
        }
        .frame(width: 98)
        .frame(maxHeight: .infinity , alignment: .center)

    }
    
    
    //MARK: -BODY
    var body: some View {
        VStack{
            VStack{
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
                    
                        Image("search")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24, alignment: .center)
                            .hidden()


                    
                }//:HSTACK
                .padding(.horizontal , 26)
                .padding(.top , 48)
                    Image("Sun")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 185, height: 185, alignment: .center)
                    VStack(spacing: 8){
                    
                        Text("\(String(format: "%.1f",dailyWeather.temp.day))˚")
                            .font(.title)
                            .fontWeight(.bold)
                        Text(dailyWeather.weather.count > 0 ? dailyWeather.weather[0].description : "clear")
                            .font(.title2)
                            Text(date)
                    }//:VSTACK
                    
               Spacer()
                
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
                        Text("\(String(format: "%.0f", dailyWeather.wind_speed)) km/h")
                        
                        Text("wind")
                            .opacity(0.5)
                    }//:VSTACK
                    Spacer()
                    VStack(alignment: .center, spacing: 8) {
                        Image("Humidity")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20, alignment: .center)
                        Text("\(String(format: "%.0f", dailyWeather.humidity)) %")
                        
                        Text("humidity")
                            .opacity(0.5)
                    }//:VSTACK
                    Spacer()
                    VStack(alignment: .center, spacing: 8) {
                        Image("Rainy")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24, alignment: .center)
                        Text("\(String(format: "%.0f", dailyWeather.clouds)) %")
                        
                        Text("clouds")
                            .opacity(0.5)
                    }//:VSTACK
                }//:HSTACK
                .padding(.horizontal, 50)
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width, height: 550.0)
            .background{
                RoundedRectangle(cornerRadius: 40)
                    .fill(LinearGradient(
                            gradient: Gradient(stops: [
                        .init(color: Color(#colorLiteral(red: 0.9333333373069763, green: 0.9333333373069763, blue: 0.9333333373069763, alpha: 1)), location: 0),
                        .init(color: Color(#colorLiteral(red: 0.9833333492279053, green: 0.9833333492279053, blue: 0.9833333492279053, alpha: 1)), location: 1)]),
                            startPoint: UnitPoint(x: 0.9999999701976785, y: -3.329098030580013e-8),
                            endPoint: UnitPoint(x: 0, y: 0.9999999369066982)))
                    .frame(width: UIScreen.main.bounds.width, height: 550.0)
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.20000000298023224)), radius:8, x:4, y:4)
            }
            HStack{
                Text("Temperature")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                Spacer()
            }
          
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16){
                        itemDay(title: "day", temp: dailyWeather.temp.day)
                            .padding(.leading)
                        itemDay(title: "min", temp: dailyWeather.temp.min)
                        itemDay(title: "max", temp: dailyWeather.temp.max)
                        itemDay(title: "night", temp: dailyWeather.temp.night)
                        itemDay(title: "eve", temp: dailyWeather.temp.eve)
                        itemDay(title: "morn", temp: dailyWeather.temp.morn)
                            .padding(.trailing)
                    }
                    
                }
            
           

        }//:VSTACK
        .ignoresSafeArea()
    }
}
//MARK: -PREVIEW
struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView(name: "London", dailyWeather: Daily(dt: 1652889600, temp: Temp(day: 23, min: 13, max: 27, night: 12, eve: 16, morn: 12), humidity: 12, wind_speed: 34, dew_point: 45, clouds: 12, weather: []), date: "18/3/22")
    }
}
