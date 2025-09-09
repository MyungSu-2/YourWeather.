//
//  WeatherManager.swift
//  YourWeather.
//
//  Created by 박선린 on 9/9/25.
//
import SwiftUI
import WeatherKit
import CoreLocation

@Observable
class WeatherManager {
    
    static let shared = WeatherManager()
    private init() {}
    
    func fetchOWM(city: String, apiKey: String) async -> OWMWeather? {
        var comps = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather")!
        comps.queryItems = [
            .init(name: "q", value: city),
            .init(name: "appid", value: apiKey),
            .init(name: "units", value: "metric"),
            .init(name: "lang", value: "kr") // 설명 한국어
        ]
        do {
            let (data, resp) = try await URLSession.shared.data(from: comps.url!)
            guard (resp as? HTTPURLResponse)?.statusCode == 200 else { return nil }
            return try JSONDecoder().decode(OWMWeather.self, from: data)
        } catch {
            return nil
        }
    }
    
}
