//
//  CustomTableViewCellFac.swift
//  WeatherApp
//
//  Created by Metehan Karadeniz on 11.07.2023.
//

import UIKit
func setWeatherIconImageView() -> UIImageView {
  let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
    
    
  return imageView
}
func setTableViewDateLabel() -> UILabel {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.sizeToFit()
      return label
  }
func setMaxDegreeLabel() -> UILabel {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.sizeToFit()
      return label
  }
func setMinDegreeLabel() -> UILabel {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.sizeToFit()
      return label
  }

