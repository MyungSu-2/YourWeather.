//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by 최명수 on 2025/9/9.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry()
    }

    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> ()) {
        let entry = WeatherEntry()
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [WeatherEntry] = []
        let weatherDatas: [OWMWeather] = loadWeatherData()
        if weatherDatas.count < 2 {
            entries.append(WeatherEntry())
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        } else {
            
            let entry = WeatherEntry(date: Date(), location1: weatherDatas[0].name, weatherDescription1: weatherDatas[0].weather.first!.description, temperature1: String(format: "%.1f", weatherDatas[0].main.temp), minTemp1: String(format: "%.1f", weatherDatas[0].main.temp_min), maxTemp1: String(format: "%.1f", weatherDatas[0].main.temp_max), location2: weatherDatas[1].name, weatherDescription2: weatherDatas[1].weather.first!.description, temperature2: String(format: "%.1f", weatherDatas[1].main.temp), minTemp2: String(format: "%.1f", weatherDatas[1].main.temp_min), maxTemp2: String(format: "%.1f", weatherDatas[1].main.temp_max))
            
            entries.append(entry)
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
    
    func loadWeatherData() -> [OWMWeather] {
        let appGroupID = "group.com.YourWeather_"
        let sharedDefaults = UserDefaults(suiteName: appGroupID)!
        
        var weatherDataArray: [OWMWeather] = []
        do {
            if let data = sharedDefaults.data(forKey: "myWeatherData") {
                let weatherData = try JSONDecoder().decode(OWMWeather.self, from: data)
                weatherDataArray.append(weatherData)
                print("!!!!!")
            }
            
            if let data = sharedDefaults.data(forKey: "selectedWeatherData") {
                let weatherData = try JSONDecoder().decode(OWMWeather.self, from: data)
                weatherDataArray.append(weatherData)
                print("???????")
            }
            return weatherDataArray
        } catch {
            print("Error with load weather data: \(error.localizedDescription)")
            return []
        }
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct WeatherEntry: TimelineEntry {
    let date: Date
    let location1: String
    let weatherDescription1: String
    let temperature1: String
    let minTemp1: String
    let maxTemp1: String
    let location2: String
    let weatherDescription2: String
    let temperature2: String
    let minTemp2: String
    let maxTemp2: String
    
    init(date: Date = Date(), location1: String = "서울특별시", weatherDescription1: String = "맑음", temperature1: String = "28℃", minTemp1: String = "31℃", maxTemp1: String = "20℃", location2: String = "부산광역시", weatherDescription2: String = "흐림", temperature2: String = "27℃", minTemp2: String = "30℃", maxTemp2: String = "22℃") {
        self.date = date
        self.location1 = location1
        self.weatherDescription1 = weatherDescription1
        self.temperature1 = temperature1
        self.minTemp1 = minTemp1
        self.maxTemp1 = maxTemp1
        self.location2 = location2
        self.weatherDescription2 = weatherDescription2
        self.temperature2 = temperature2
        self.minTemp2 = minTemp2
        self.maxTemp2 = maxTemp2
    }
    
}

struct WeatherWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry

    var body: some View {
        switch family {
        case .systemSmall:
            VStack {
                Text(entry.location1)
                Text(entry.temperature1)
                Text(entry.weatherDescription1)
            }
        case .systemMedium:
            HStack {
                VStack {
                    Text(entry.location1)
                    Text(entry.temperature1)
                    Text(entry.weatherDescription1)
                }
                .padding()
                Spacer()
                VStack {
                    Text(entry.location2)
                    Text(entry.temperature2)
                    Text(entry.weatherDescription2)
                }
                .padding()
            }
        default:
            VStack {
                Text(entry.location1)
                Text(entry.temperature1)
                Text(entry.weatherDescription1)
            }
        }
    }
}

struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                WeatherWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                WeatherWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
