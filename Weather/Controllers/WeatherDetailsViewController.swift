//
//  WeatherDetailsViewController.swift
//  Weather
//
//  Created by Admin on 12.08.2021.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    
    var cityWeather: CityWeather?
    let dateFormatter = DateFormatter()
    var guid: UILayoutGuide!
    
    let verticalStackView: UIStackView = {
       let stcView = UIStackView()
        stcView.alignment = .center
        stcView.axis = .vertical
        stcView.translatesAutoresizingMaskIntoConstraints = false
        return stcView
    }()
    
    let daysTableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.register(ForecastComponentTableViewCell.self, forCellReuseIdentifier: "tableCellId")
        return tableView
    }()
    
    let cityNameLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 30)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let conditionLabel: UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let temperatureLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 30)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let hourlyWeatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HourlyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.locale = Locale(identifier: "ru_RU")        
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE")
        //setupView()
        // Do any additional setup after loading the view.
    }
    func getData(weather: CityWeather?) {
        self.cityWeather = weather
        cityNameLabel.text = weather?.cityName
        conditionLabel.text = Condition(rawValue: weather?.fact?.condition ?? "")?.getRusCondition()
        temperatureLabel.text = "\(weather?.fact?.temp ?? 0)°C"
        setupView()
    }
    
    private func setupView() {
        guid = view.safeAreaLayoutGuide
        view.backgroundColor = .white
        hourlyWeatherCollectionView.delegate = self
        hourlyWeatherCollectionView.dataSource = self
        daysTableView.delegate = self
        daysTableView.dataSource = self
        view.addSubview(verticalStackView)
        view.addSubview(hourlyWeatherCollectionView)
        view.addSubview(daysTableView)
        verticalStackView.addArrangedSubview(cityNameLabel)
        verticalStackView.addArrangedSubview(conditionLabel)
        verticalStackView.addArrangedSubview(temperatureLabel)
        
        makeVerticalStackViewConstraints()
        makeCollectionViewConstraints()
        makeTableViewConstraints()
    }
    
    private func makeVerticalStackViewConstraints() {
        verticalStackView.topAnchor.constraint(equalTo: guid.topAnchor, constant:15).isActive = true
        verticalStackView.leftAnchor.constraint(equalTo: guid.leftAnchor, constant: 10).isActive = true
        verticalStackView.rightAnchor.constraint(equalTo: guid.rightAnchor).isActive = true
        //verticalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func makeCollectionViewConstraints() {
        hourlyWeatherCollectionView.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor).isActive = true
        hourlyWeatherCollectionView.leftAnchor.constraint(equalTo: guid.leftAnchor).isActive = true
        hourlyWeatherCollectionView.rightAnchor.constraint(equalTo: guid.rightAnchor).isActive = true
        hourlyWeatherCollectionView.heightAnchor.constraint(equalTo: guid.widthAnchor, multiplier: 0.2).isActive = true
    }
    
    private func makeTableViewConstraints() {
        daysTableView.topAnchor.constraint(equalTo: hourlyWeatherCollectionView.bottomAnchor).isActive = true
        daysTableView.leftAnchor.constraint(equalTo: guid.leftAnchor).isActive = true
        daysTableView.rightAnchor.constraint(equalTo: guid.rightAnchor).isActive = true
        daysTableView.bottomAnchor.constraint(equalTo: guid.bottomAnchor).isActive = true
    }
}

extension WeatherDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityWeather?.forecasts?.first?.hours?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! HourlyWeatherCollectionViewCell
        let hour = cityWeather?.forecasts?.first?.hours?[indexPath.item]
        let hourString =  hour?.hour
        cell.setCell(hour: hourString, temperature: hour?.temp, imageUrl: hour?.icon)
        cell.backgroundColor = .clear
        return cell
    }
}

extension WeatherDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = cityWeather?.forecasts?.count else {
            return 0
        }
        return  count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCellId") as! ForecastComponentTableViewCell
        
        guard let forecast = cityWeather?.forecasts?[indexPath.item + 1] else {
            return cell
        }
        cell.setView(dayOfWeek: dateFormatter.string(from: Date().adding(.day, value: indexPath.item)), temperature: "\(forecast.parts?.day_short?.temp ?? 0)")
        
        return cell
    }
}
