//
//  HourlyWeatherCollectionViewCell.swift
//  Weather
//
//  Created by Admin on 12.08.2021.
//

import UIKit

class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    let hourLabel: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let temperatureLabel: UILabel = {
       let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let conditionLabel: UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let verticalSackView: UIStackView = {
       let stkView = UIStackView()
        stkView.axis = .vertical
        stkView.alignment = .center
        stkView.translatesAutoresizingMaskIntoConstraints = false
        return stkView
    }()
    
    func setCell(hour: String? = "", temperature: Int?, imageUrl: String? = "") {
        DispatchQueue.main.async {
            self.hourLabel.text = hour
            self.temperatureLabel.text = "\(temperature ?? 0)°"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        //addSubview(cityNameLabel)
        addSubview(verticalSackView)
        //verticalSackView.addArrangedSubview(temperatureLabel)
        //verticalSackView.addArrangedSubview(conditionLabel)
        verticalSackView.addArrangedSubview(hourLabel)
        verticalSackView.addArrangedSubview(temperatureLabel)
        //makeCityNameLabelConstraints()
        makeVerticalStackViewConstraints()
        self.layoutIfNeeded()
        //makeStackViewConstraints()
    }
    
    private func makeVerticalStackViewConstraints() {
        verticalSackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        verticalSackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        verticalSackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        verticalSackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
