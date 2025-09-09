//
//  WeatherInfoCardView.swift
//  YourWeather.
//
//  Created by 최명수 on 2025/9/9.
//

import SwiftUI

// MARK: - 날씨 정보 표시 카드 뷰
// 개별 지역의 날씨 정보를 표시하는 뷰
struct WeatherInfoCardView: View {
    @Binding var location: String?
    var body: some View {
        NavigationLink {
            LocationSearchingView(location: $location)
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
                VStack {
                    HStack(alignment: .top) {
                        Text("서울특별시")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                        Spacer()
                        Text("28℃")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                    }
                    Spacer()
                    HStack(alignment: .bottom) {
                        Text("흐림")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                        Spacer()
                        Text("최고: 31℃")
                            .foregroundStyle(.primary)
                        Text("최저: 20℃")
                            .foregroundStyle(.primary)
                    }
                }
                .padding()
                .frame(width: .infinity, height: 150)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
            }
        }
    }
}

#Preview {
    WeatherInfoCardView(location: .constant("서울특별시"))
}

#Preview {
    WeatherInfoCardView(location: .constant(nil))
}
