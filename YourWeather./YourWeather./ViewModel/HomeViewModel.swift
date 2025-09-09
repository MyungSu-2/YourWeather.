//
//  HomeViewModel.swift
//  YourWeather.
//
//  Created by 최명수 on 2025/9/9.
//

import Foundation

@Observable
final class HomeViewModel {
    var myLocation: String?
    var myLocationKor: String?
    var selectedLocation: String?
    var selectedLocationKor: String?
    
    init() {
        if let myLocation = UserDefaults.standard.string(forKey: "myLocation") {
            self.myLocation = myLocation
        }
        if let selectedLocation = UserDefaults.standard.string(forKey: "selectedLocation") {
            self.selectedLocation = selectedLocation
        }
    }
}
