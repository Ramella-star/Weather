//
//  CitiListTableViewCell.swift
//  Weather
//
//  Created by Admin on 11.08.2021.
//

import UIKit

class CityListTableViewCell: UITableViewCell {
    
    let cityNameLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 22)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let temperatureLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 30)
        lbl.textAlignment = .right
        lbl.text = "0"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let conditionLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .light)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let verticalSackView: UIStackView = {
       let stkView = UIStackView()
        stkView.axis = .vertical
        stkView.translatesAutoresizingMaskIntoConstraints = false
        return stkView
    }()
    
    let horizontalStackView: UIStackView = {
        let stkView = UIStackView()
         stkView.translatesAutoresizingMaskIntoConstraints = false
         return stkView
    }()
    
    func setCell(data: CityWeather) {
        DispatchQueue.main.async {
            self.cityNameLabel.text = data.cityName
            self.temperatureLabel.text = "\(data.fact?.temp ?? 0)°C"
            self.conditionLabel.text = Condition(rawValue: data.fact?.condition ?? "")?.getRusCondition()            
            
            self.layoutIfNeeded()
        }        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupView() {
        addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(verticalSackView)
        horizontalStackView.addArrangedSubview(temperatureLabel)
        verticalSackView.addArrangedSubview(cityNameLabel)
        verticalSackView.addArrangedSubview(conditionLabel)
        makeHorizontalStackViewConstraints()
    }
    
    private func makeCityNameLabelConstraints() {
        cityNameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cityNameLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        cityNameLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    private func makeHorizontalStackViewConstraints() {
        horizontalStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        horizontalStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        horizontalStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -25).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    private func makeVerticalStackViewConstraints() {
        verticalSackView.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor).isActive = true
        verticalSackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        verticalSackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        verticalSackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
