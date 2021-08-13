//
//  CitiesWeather.swift
//  Weather
//
//  Created by Admin on 11.08.2021.
//

import Foundation

enum Condition: String {
    case clear = "clear"
    case partly_cloudy = "partly-cloudy"
    case cloudy = "cloudy"
    case overcast = "overcast"
    case drizzle = "drizzle"
    case light_rain = "light-rain"
    case rain = "rain"
    case moderate_rain = "moderate-rain"
    case heavy_rain = "heavy-rain"
    case continuous_heavy_rain = "continuous-heavy-rain"
    case showers = "showers"
    case wet_snow = "wet-snow"
    case light_snow = "light-snow"
    case snow = "snow"
    case snow_showers = "snow-showers"
    case hail = "hail"
    case thunderstorm = "thunderstorm"
    case thunderstorm_with_rain = "thunderstorm-with-rain"
    case thunderstorm_with_hail = "thunderstorm-with-hail"
    
    func getRusCondition() -> String{
        switch self {
        case .clear:
            return "ясно"
        case .partly_cloudy:
            return "малооблачно"
        case .cloudy:
            return "облачно с прояснениями"
        case .overcast:
            return "пасмурно"
        case .drizzle:
            return "морось"
        case .light_rain:
            return "небольшой дождь"
        case .rain:
            return "дождь"
        case .moderate_rain:
            return "умеренно сильный дождь"
        case .heavy_rain:
            return "сильный дождь"
        case .continuous_heavy_rain:
            return "длительный сильный дождь"
        case .showers:
            return "ливень"
        case .wet_snow:
            return "дождь со снегом"
        case .light_snow:
            return "небольшой снег"
        case .snow:
            return "снег"
        case .snow_showers:
            return "снегопад"
        case .hail:
            return "град"
        case .thunderstorm:
            return "гроза"
        case .thunderstorm_with_rain:
            return "дождь с грозой"
        case .thunderstorm_with_hail:
            return "гроза с градом"
        }
    }
}

struct CityWeather: Codable {
    var cityName: String?
    let now: Int?
    let now_dt: String?
    let info: Info?
    let fact: Fact?
    let forecasts: [Forecasts]?
}

struct Info: Codable {
    let lat: Double
    let lon: Double
}

struct Fact: Codable {
    let temp: Int?
    let condition: String?
    let icon: String?
    let phenom_icon: String?
}

struct Forecasts: Codable {
    let date: String?
    let hours: [Hour]?
    let parts: Parts?
    
}

struct Hour: Codable {
    let hour: String?
    let icon: String?
    let temp: Int?
}

struct Parts: Codable {
    let day_short: PartModel?
    
}

struct PartModel: Codable {
    let condition: String?
    let icon: String?
    let temp: Int?
}


