//
//  CustomTableView.swift
//  WeatherApp
//
//  Created by Metehan Karadeniz on 11.07.2023.
//

import UIKit

class CustomTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
       
        private var weathers: [WeatherData] = []
        let cellId = "customCell"
      private var userCurrentCity = ""
   
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        // UITableView'nin ayarlarını yapmak için burayı kullanın.
        // Örneğin, delegeleri ayarlamak, hücre sınıfını kaydetmek ve görünüm özelliklerini ayarlamak.
        setUpTableView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpTableView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            WeatherViewModel.shared.fetchWeathers(city: HomeViewController.userCurrentCity) { [weak self] weathers in
                self!.weathers = weathers
                DispatchQueue.main.async {
                    self?.reloadData()
                }
        }
       
            
        }
        self.delegate = self
        self.dataSource = self
        self.register(CustomTableViewCell.self, forCellReuseIdentifier: cellId)
        self.separatorStyle = .none
        self.backgroundColor = .clear
        // UITableView'nin görünümünü özelleştirmek için burada gerekli ayarları yapın.
        // Örneğin, arka plan rengi, hücre yüksekliği, vb.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return weathers.count
    }
    // her sectionda bir satır olacak
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 2))
        footerView.backgroundColor = .white
        footerView.alpha = 0.5
               
        return footerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 2 // boşluk yüksekliği
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomTableViewCell
        // Hücrenin içeriğini güncellemek için burayı kullanın.
        // Örneğin, hücre içindeki öğelerin görünümünü ayarlayın veya verileri yükleyin.
        let weatherState = weathers[indexPath.section] // Hücreye yazdırılacak veri
       
        let dayLabelItem = weatherState.day
        let minDegreeLabelItem = weatherState.min
        let maxDegreeLabelItem = weatherState.max
        let weatherIconItemUrl = weatherState.icon
        
        cell.configureLabels(day: dayLabelItem, maxDegree: minDegreeLabelItem, minDegree: maxDegreeLabelItem)
        cell.configureIconImage(url: weatherIconItemUrl)
        return cell
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.isScrollEnabled = false
    }
    
   
}
