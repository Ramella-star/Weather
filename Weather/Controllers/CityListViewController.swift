//
//  ViewController.swift
//  Weather
//
//  Created by Admin on 11.08.2021.
//

import UIKit

protocol CityListViewDelegate{
    //обновление списка городов
   func refreshData()
    //открытие детализации
    func openCityDetalization(city: CityWeather?)
}

class CityListViewController: UIViewController {
    
    var cityListViewModel: CityListViewModel?
     let cityCellId: String = "CityCellIdentifier"
    var guid: UILayoutGuide!
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Введите город"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CityListTableViewCell.self, forCellReuseIdentifier: cityCellId)
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guid = view.safeAreaLayoutGuide
        cityListViewModel = CityListViewModel(delegate: self)
        setupView()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    //добавление view и настройка constraints
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        makeSearchBarConstraints()
        makeTableViewConstraints()
    }
    
    private func makeSearchBarConstraints() {
        searchBar.topAnchor.constraint(equalTo: guid.topAnchor, constant: 15).isActive = true
        searchBar.leftAnchor.constraint(equalTo: guid.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: guid.rightAnchor).isActive = true
    }
    
    private func makeTableViewConstraints() {
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        tableView.leftAnchor.constraint(equalTo: guid.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: guid.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: guid.bottomAnchor).isActive = true
    }
}

extension CityListViewController: CityListViewDelegate {
    func openCityDetalization(city: CityWeather?) {
        guard let city = city else { return }
        let detailsViewController = WeatherDetailsViewController()
        detailsViewController.getData(weather: city)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func refreshData() {
        self.tableView.reloadData()
    }
}

extension CityListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //не сделала ограничение на ввод цифр
        guard let text = searchBar.text , text != "" else {
            return
        }
        cityListViewModel?.getCityWeather(searchString: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cityListViewModel?.deleteSearchString()
        searchBar.text = ""
    }
}

extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.cityListViewModel?.citiesFound.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cityCellId) as! CityListTableViewCell
        guard let city  = cityListViewModel?.citiesFound[indexPath.item] else {
            return cell
        }
        cell.setCell(data: city)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let detailsViewController = WeatherDetailsViewController()
        detailsViewController.getData(weather: cityListViewModel?.citiesFound[indexPath.item])
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

