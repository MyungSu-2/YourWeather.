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
    var selectedLocation: String? = "Seoul"
    
    init() {
        print("55")
        if let myLocation = UserDefaults.standard.string(forKey: "myLocation") {
            self.myLocation = myLocation
            print("!")
        } else { print("!!") }
        if let selectedLocation = UserDefaults.standard.string(forKey: "selectedLocation") {
            self.selectedLocation = selectedLocation
            print("?")
        } else { print("??") }
    }
}
