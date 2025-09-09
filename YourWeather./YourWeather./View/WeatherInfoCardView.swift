//
//  WeatherInfoCardView.swift
//  YourWeather.
//
//  Created by 최명수 on 2025/9/9.
//

import SwiftUI
import WidgetKit

// MARK: - 날씨 정보 표시 카드 뷰
// 개별 지역의 날씨 정보를 표시하는 뷰
struct WeatherInfoCardView: View {
    @Binding var location: String?
    @Binding var locationKor: String?
    @State var viewModel: WeatherViewModel = WeatherViewModel()
    var weatherInfoFlag: Bool = false
    
    var body: some View {
        NavigationLink {
            LocationSearchingView(location: $location, locationKor: $locationKor)
        } label: {
            if location == nil {
                Text("지역 선택")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 150)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(20)
            } else {
                if let weatherData = viewModel.weatherData {
                    VStack {
                        HStack(alignment: .top) {
                            Text("\(locationKor ?? "알 수 없음")")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.primary)
                            Spacer()
                            Text("\(String(format: "%.1f", weatherData.main.temp))℃")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.primary)
                        }
                        Spacer()
                        HStack(alignment: .bottom) {
                            Text("\(weatherData.weather.first!.description.capitalized)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.primary)
                            Spacer()
                            Text("최고: \(String(format: "%.1f", weatherData.main.temp_max))℃")
                                .foregroundStyle(.primary)
                            Text("최저: \(String(format: "%.1f", weatherData.main.temp_min))℃")
                                .foregroundStyle(.primary)
                        }
                    }
                    .padding()
                    .frame(width: .infinity, height: 150)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(20)
                } else {
                    VStack {
                        Text(locationKor ?? "알 수 없음")
                        Text("날씨 정보 없음")
                    }
                    .foregroundColor(.black)
                }
            }
        }
//        .onChange(of: location) {
//            print("!!!location changed")
//            if let location = location {
//                viewModel.cityName = location
//                viewModel.saveWeatherToSharedDefaults(to: weatherInfoFlag)
//                WidgetCenter.shared.reloadAllTimelines()
//            }
//        }
        .onAppear {
            if let location = location {
                viewModel.cityName = location
                viewModel.saveWeatherToSharedDefaults(to: weatherInfoFlag)
                if weatherInfoFlag == true {
                    WidgetCenter.shared.reloadAllTimelines()
                }
            }
        }
    }
}

#Preview {
    WeatherInfoCardView(location: .constant("Seoul"), locationKor: .constant("서울특별시"))
}

#Preview {
    WeatherInfoCardView(location: .constant(nil), locationKor: .constant(nil))
}
