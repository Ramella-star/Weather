//
//  ForecastComponentTableViewCell.swift
//  Weather
//
//  Created by Admin on 11.08.2021.
//

import UIKit

class ForecastComponentTableViewCell: UITableViewCell {
    
    let horizontalStackView: UIStackView = {
       let stcView = UIStackView()
        stcView.translatesAutoresizingMaskIntoConstraints = false
        return stcView
    }()
    
    let dayOfWeekLabel: UILabel = {
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
    
    func setView(dayOfWeek: String, temperature: String) {
        //DispatchQueue.main.async {
            self.dayOfWeekLabel.text = dayOfWeek
            self.temperatureLabel.text = temperature + "°"
        layoutIfNeeded()
            self.setupView()
        //}
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupView() {
        addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(dayOfWeekLabel)
        horizontalStackView.addArrangedSubview(temperatureLabel)
        makeHorizontalViewConstraints()
    }
    
    private func makeHorizontalViewConstraints() {
        horizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        horizontalStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        horizontalStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
