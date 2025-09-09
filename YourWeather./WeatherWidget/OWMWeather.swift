//
//  WeatherKitDataModel.swift
//  YourWeather.
//
//  Created by 박선린 on 9/9/25.
//
import Foundation
struct OWMWeather: Codable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int
    let sys: Sys
    let timezone: Int
    let name: String

    struct Coord: Codable { let lon: Double; let lat: Double }
    struct Weather: Codable { let id: Int; let main: String; let description: String; let icon: String }
    struct Main: Codable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let humidity: Int
        let sea_level: Int?
        let grnd_level: Int?
    }
    struct Wind: Codable { let speed: Double; let deg: Double? }
    struct Clouds: Codable { let all: Int }
    struct Sys: Codable { let country: String; let sunrise: Int; let sunset: Int }
}
