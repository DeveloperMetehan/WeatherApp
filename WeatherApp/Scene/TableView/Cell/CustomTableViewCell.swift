//
//  CustomTableViewCell.swift
//  WeatherApp
//
//  Created by Metehan Karadeniz on 11.07.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    // UITableViewCell içindeki öğeleri tanımlamak için IBOutlet'ler ekleyin.
    // Örneğin, bir UIImageView, UILabel veya UIView gibi öğeler olabilir
    
    lazy private var dayLabel = setTableViewDateLabel()
    lazy var iconImageView = setWeatherIconImageView()
    private lazy var horizontalStackView: UIStackView = {
          let theStackView = UIStackView()
            theStackView.translatesAutoresizingMaskIntoConstraints = false
            theStackView.axis = .horizontal
            theStackView.distribution = .fill
            theStackView.spacing = 25
          return theStackView
      }()
    lazy private var minDegreeLabel = setMinDegreeLabel()
    lazy private var maxDegreeLabel = setMaxDegreeLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Hücrenin tasarımını programatik olarak ayarlamak için burayı kullanın.
        // Örneğin, öğeleri oluşturun, yerleştirin ve görünümünüzü özelleştirin.
        setUpViews()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureLabels(day: String,maxDegree: String,minDegree: String) {
        dayLabel.text = day
        minDegreeLabel.text = minDegree
        maxDegreeLabel.text = maxDegree
    }
    func configureIconImage(url: String) {
        DispatchQueue.main.async {
            self.iconImageView.setImage(imageUrl: url)
        }
     
    }
    private func setUpViews() {
        // Öğeleri oluşturun, yerleştirin, görünümü özelleştirin vb.
        // Burada dilediğiniz şekilde hücrenin görünümünü yapılandırabilirsiniz.
        self.backgroundColor = .clear
        
        self.addSubview(dayLabel)
        self.addSubview(iconImageView)
        self.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(minDegreeLabel)
        horizontalStackView.addArrangedSubview(maxDegreeLabel)
        
        NSLayoutConstraint.activate([
            
            dayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5.0),
            iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            horizontalStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
     ])
    }
}
