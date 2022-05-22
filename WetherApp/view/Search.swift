//
//  Search.swift
//  WetherApp
//
//  Created by Blur on 2/26/1401 AP.
//

import SwiftUI

struct Search: View {
    //MARK: -PEROPERTIES
    @ObservedObject var cityModel = CityViewModel()
    @State var cityName : String = ""
    @State private var showingAlert = false
    
    //MARK: -BODY
    var body: some View {
        VStack {
            HStack{
                Button {
                    if cityName.isEmpty {
                        showingAlert = true
                    }else{
                        self.cityModel.fetchCity(cityName: cityName)
                    }
                } label: {
                    Image("search")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24, alignment: .center)
                        .opacity(cityName.isEmpty ? 0.5 : 1)
                }

               
                TextField("enter city name", text: $cityName) {
                    if cityName.isEmpty {
                        showingAlert = true
                    }else{
                        self.cityModel.fetchCity(cityName: cityName)
                    }
                }
            }
            .padding(.vertical,8)
            .padding(.horizontal , 16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color("strok"),lineWidth: 2))
            .background(
                Color.white
                    .cornerRadius(16)
                    .blur(radius: 3)
                    .opacity(0.5)
            )
            .padding(30)
            .alert("enter city name", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
            
            
            ScrollView{
                switch cityModel.statusOfApi {
                case .SUCSESFULL :
                    if self.cityModel.city.count > 0 {
                        ForEach(self.cityModel.city ,id: \.name){ item in
                            NavigationLink {
                                Home(lat: item.lat, lon: item.lon, name: item.name)
                                    .navigationBarHidden(true)
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                HStack{
                                    Text(item.name)
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                        .padding()
                                    Spacer()
                                    Text(item.state)
                                        .foregroundColor(.black)
                                        .opacity(0.7)
                                    Spacer()
                                  Image(systemName: "chevron.right")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(.black )
                                        .opacity(0.5)
                                        .frame(width: 18, height: 18, alignment: .center)
                                        
                                        .padding(.trailing,8)

                                }
                            }
                            .frame(maxWidth: .infinity)
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color("strok"), lineWidth: 2))
                            .background(Color("BackItemSearch"))
                            .cornerRadius(16)
                            .padding(.horizontal)
                        }//:LOOP

                    }else{
                        Text("No cities found")
                            .fontWeight(.bold)
                            .foregroundColor(Color.red)
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(16)
                    }
                case .ERROR :
                    Button {
                        cityModel.fetchCity(cityName: cityName)
                    } label: {
                        Text("Try again")
                            .fontWeight(.bold)
                            .foregroundColor(Color.red)
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(16)
                    }
                case .INPROGRESS :
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity, alignment: .center)
                default:
                   Spacer()
                }
            }//:SCROLL
        }//:VSTACK
        .background(Background())
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
