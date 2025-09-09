//
//  HomeView.swift
//  YourWeather.
//
//  Created by 최명수 on 2025/9/9.
//

import SwiftUI

// MARK: - 앱 메인 화면
struct HomeView: View {
    @State var viewModel: HomeViewModel = HomeViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                // MARK: - 내 지역의 날씨 정보 표시
                HStack {
                    Text("나의 날씨")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                WeatherInfoCardView(location: $viewModel.myLocation)
                Divider()
                    .padding(.vertical, 10)
                
                // MARK: - 연인이 있는 지역의 날씨 정보 표시
                HStack {
                    Text("달링의 날씨")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                WeatherInfoCardView(location: $viewModel.selectedLocation)
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
