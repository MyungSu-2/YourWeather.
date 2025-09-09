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
}
