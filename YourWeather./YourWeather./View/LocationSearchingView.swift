//
//  LocationSearchingView.swift
//  YourWeather.
//
//  Created by 최명수 on 2025/9/9.
//

import SwiftUI
import MapKit

// MARK: - 지역 검색 뷰
// 날씨를 표시할 지역을 검색하여 선택하는 뷰
struct LocationSearchingView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var location: String?
    @Binding var locationKor: String?
    @State private var searchText = ""
    @State private var searchResults: [MKMapItem] = []
    
    var body: some View {
        VStack {
            if searchResults.isEmpty {
                Text("원하는 도시를 검색하세요.")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.gray.opacity(0.7))
            } else {
                List(searchResults, id: \.self) { item in
                    Button {
                        searchText = ""
                        Task {
                            let english = await getEnglishPlaceName(for: item.placemark.location!)
                            location = english.city
                            locationKor = item.placemark.locality ?? item.name
                            dismiss()
                        }
                    } label: {
                        HStack {
                            Text(item.placemark.locality ?? item.name ?? "알 수 없음")
                                .foregroundColor(.primary)
                            Spacer()
                            Text(item.placemark.country ?? "알 수 없음")
                                .foregroundColor(.gray.opacity(0.7))
                        }
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "도시 이름 검색")
        .onChange(of: searchText) {
            Task {
                await searchCity(for: searchText)
            }
        }
    }
    
    private func searchCity(for text: String) async {
        guard !text.isEmpty else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = text
        request.resultTypes = [.address]
        
        let search = MKLocalSearch(request: request)
        do {
            let response = try await search.start()
            DispatchQueue.main.async {
                self.searchResults = response.mapItems
            }
        } catch {
            print("검색 오류: \(error.localizedDescription)")
        }
    }
    
    private func getEnglishPlaceName(for location: CLLocation) async -> (city: String, country: String) {
        let geocoder = CLGeocoder()
        let placemarks = try? await geocoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "en_US"))
        let placemark = placemarks?.first
        
        let city = placemark?.locality ?? placemark?.name ?? "Unknown"
        let country = placemark?.country ?? "Unknown"
        return (city, country)
    }
}

#Preview {
    HomeView()
}
