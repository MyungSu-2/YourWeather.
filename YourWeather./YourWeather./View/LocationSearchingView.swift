//
//  LocationSearchingView.swift
//  YourWeather.
//
//  Created by 최명수 on 2025/9/9.
//

import SwiftUI

// MARK: - 지역 검색 뷰
// 날씨를 표시할 지역을 검색하여 선택하는 뷰
struct LocationSearchingView: View {
    @Binding var location: String?
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    LocationSearchingView(location: .constant(""))
}
