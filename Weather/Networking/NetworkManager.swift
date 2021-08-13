//
//  Networking.swift
//  Weather
//
//  Created by Admin on 11.08.2021.
//


import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let baseUrlString = "https://api.weather.yandex.ru/v2/"
    private let USTopHeadline = "forecast"
    
    func getCityWeather( cities: [City], complition: @escaping ([CityWeather]?) -> ()) {
        var whaterCities: [CityWeather] = []
        var requestCount = 0
        for city in cities {
            let urlString = "\(baseUrlString)\(USTopHeadline)"
            guard let url = URL(string: urlString) else {
                return
            }
            
            ///параметры для запросов
            let params: [String: String] = ["lat": "\(city.latitude)",
                                            "lon": "\(city.longitude)"]
            let headers = HTTPHeaders(["X-Yandex-API-Key":"dcf9e18f-35e6-408b-a101-2f1c5048aa3e"])
            ///используем библиотеку Alamofire
            AF.request(url, parameters: params, headers: headers)
                .validate()
                .responseDecodable (of: CityWeather.self ) {response in
                    ///проверяем ответ
                    switch response.result{
                    ///при успешном ответе
                    case .success(var value):
                        value.cityName = city.cityName
                        whaterCities.append(value)
                    case .failure(let error):
                        print(error.responseCode, error.errorDescription)
                    }
                    requestCount += 1
                    if requestCount == cities.count {
                        complition(whaterCities)
                    }
                }
        }
    }
}

