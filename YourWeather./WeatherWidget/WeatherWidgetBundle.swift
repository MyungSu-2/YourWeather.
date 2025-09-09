//
//  WeatherWidgetBundle.swift
//  WeatherWidget
//
//  Created by 최명수 on 2025/9/9.
//

import WidgetKit
import SwiftUI

@main
struct WeatherWidgetBundle: WidgetBundle {
    var body: some Widget {
        WeatherWidget()
        WeatherWidgetControl()
    }
}
