//
//  CityListViewModel.swift
//  Weather
//
//  Created by Admin on 11.08.2021.
//

import Foundation
import UIKit
import MapKit

class CityListViewModel {
    
    var cities: [City] = []
    var citiesFound : [CityWeather] = []
    var mainValue: [CityWeather] = []
    var delegate: CityListViewDelegate?
    let geoCoder  = CLGeocoder()
    
    
    init(delegate: CityListViewDelegate) {
        cities = getData()
        self.delegate = delegate
        //self.delegate?.redreshData()
        NetworkManager.shared.getCityWeather( cities: cities, complition: { ( cities) in
            guard let cities = cities else {
                delegate.refreshData()
                return
            }
            DispatchQueue.main.async {
                self.mainValue = cities
                self.citiesFound = cities
                delegate.refreshData()
            }
        })
    }
    
    func deleteSearchString() {
        citiesFound = mainValue
        delegate?.refreshData()
    }
    
    func getCityWeather(searchString: String) {
        
        if let city = mainValue.first(where: {$0.cityName == searchString}) {
            citiesFound = [city]
            delegate?.openCityDetalization(city: city)
            return
        }
        geoCoder.geocodeAddressString(searchString, completionHandler: {placemark, error  in
            if error == nil {
                guard let coordinate = placemark?.first?.location?.coordinate, let latitude = coordinate.latitude as? Double, let longitude = coordinate.longitude as? Double else {
                    return
                }
                
                    let city = City(cityName: searchString, latitude: String(latitude), longitude: String(longitude))
                NetworkManager.shared.getCityWeather(cities: [city], complition: { weather in
                    self.delegate?.openCityDetalization(city: weather?.first)
                })
               
            } else {
                self.citiesFound = []
                self.delegate?.refreshData()
            }
            
        })
    }
    
    func getData()-> [City] {
        let moscow = City(cityName: "Москва",latitude: "55.45",longitude: "37.37")
        let piter = City(cityName: "Санкт-Петербург", latitude: "59.56", longitude: "30.19")
        let novosibirsk = City(cityName: "Новосибирск", latitude: "55.1", longitude: "82.56")
        let ekaterinburg = City(cityName: "Екатеринбург", latitude: "56.51", longitude: "60.36")
        let samara = City(cityName: "Самара", latitude: "53.14", longitude: "50.10")
        let omsk = City(cityName: "Омск", latitude: "54.59", longitude: "73.22")
        let kazan = City(cityName: "Казань", latitude: "55.47", longitude: "49.10")
        let ufa = City(cityName: "Уфа", latitude: "54.49", longitude: "56.4")
        let krasnoyarsk = City(cityName: "Красноярск", latitude: "56.1", longitude: "93.4")
        let voronezh = City(cityName: "Воронеж", latitude: "51.43", longitude: "39.16")
        
        return [moscow, piter, novosibirsk, ekaterinburg, samara, omsk, kazan, ufa, krasnoyarsk, voronezh]
    }
}
