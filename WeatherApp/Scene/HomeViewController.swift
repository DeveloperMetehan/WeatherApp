//
//  ViewController.swift
//  WeatherApp
//
//  Created by Metehan Karadeniz on 11.07.2023.
//

import UIKit
import CoreLocation

final class HomeViewController: UIViewController {
    private var locationManager = CLLocationManager()
    private var usersCurrentLatitude: Double?
    private var usersCurrentLongitude: Double?
    private var didPerformGeocode = false
    private var usersLocation = ""
    static var userCurrentCity = ""
    private lazy var backgroundImageView: UIImageView = {
       let imagev = UIImageView()
            imagev.translatesAutoresizingMaskIntoConstraints = false
            imagev.image = UIImage(named: "MorningImage")
        return imagev
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 30)
            label.textAlignment = .center
            label.sizeToFit()
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
       let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 30)
            label.textAlignment = .center
            label.sizeToFit()
        return label
    }()
    private lazy var currentDayWeatherImageView: UIImageView = {
       let imagev = UIImageView()
            imagev.translatesAutoresizingMaskIntoConstraints = false
            imagev.image = UIImage(named: "MorningImage")
            imagev.heightAnchor.constraint(equalToConstant: 90.0).isActive = true
            imagev.widthAnchor.constraint(equalToConstant: 90.0).isActive = true
            imagev.isHidden = true
        return imagev
    }()
    private lazy var degreeLabel: UILabel = {
       let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 60)
            label.textAlignment = .center
            label.sizeToFit()
        return label
    }()
    private lazy var dateLabel: UILabel = {
       let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textAlignment = .center
            label.sizeToFit()
        return label
    }()
    lazy private var customTableView: CustomTableView = {
            let tableView = CustomTableView(frame: .zero, style: .plain)
                tableView.translatesAutoresizingMaskIntoConstraints = false
           return tableView
         }()
   
     private var weathers: [WeatherData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraint()
        setBackgroundImage()
    }
    func getDatasAndSetObject(city:String){
        WeatherViewModel.shared.fetchWeathers(city: city) { [weak self] weathers in
            DispatchQueue.main.async {
                self?.descriptionLabel.text = weathers[0].description
                self?.degreeLabel.text = weathers[0].degree
                self?.dateLabel.text = Date().formatDate(dateString: weathers[0].date)
                self!.currentDayWeatherImageView.isHidden = false
                self?.currentDayWeatherImageView.setImage(imageUrl: weathers[0].icon)
            }
        }
    }
    
   private func setBackgroundImage() {
        let currentHour = Date().getCurrentHour()

        var backgroundImageName: String
        
        if currentHour >= 6 && currentHour < 20 {
            backgroundImageName = "MorningImage"
        } else {
            backgroundImageName = "NightIcon"
        }
       
        let backgroundImage = UIImage(named: backgroundImageName)
        backgroundImageView.image = backgroundImage
    }

    private func setConstraint(){
       
        view.addSubview(backgroundImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(currentDayWeatherImageView)
        view.addSubview(degreeLabel)
        view.addSubview(dateLabel)
        view.addSubview(customTableView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            currentDayWeatherImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
            currentDayWeatherImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            degreeLabel.topAnchor.constraint(equalTo: currentDayWeatherImageView.bottomAnchor, constant: 5),
            degreeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            dateLabel.topAnchor.constraint(equalTo: degreeLabel.bottomAnchor, constant: 10),
            dateLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            customTableView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor,constant: 20),
            customTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            customTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            customTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10)
            
        ])
    }
  
}
extension HomeViewController: CLLocationManagerDelegate {
    override func viewDidAppear(_ animated: Bool) {
            determineCurrentLocation()
        }
  
   private func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        DispatchQueue.global().async {
              if CLLocationManager.locationServicesEnabled() {
                  self.locationManager.startUpdatingLocation()
              }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Error - locationManager: \(error.localizedDescription)")
        }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
            //kullanıcı konuma izin verdiyse:
            case .authorizedAlways , .authorizedWhenInUse:
                print("authorized always and when in use")
                break
            
            //kullanıcı konum iznini reddettiyse:
            case .denied:
                
                print("authorized denied or restricted")
            
                break
            default:
                break
            }
     }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last! as CLLocation
            usersCurrentLatitude = location.coordinate.latitude
            usersCurrentLongitude = location.coordinate.longitude
        
                //kullanicinin konumunu sonradan pinliyorum çünkü diğer pinleri koymadan zoomluyordu ve region'ı ayarlayamıyordum.
               
            
                guard !didPerformGeocode else { return }
                // otherwise, update state variable, stop location services and start geocode
                
                didPerformGeocode = true
                locationManager.stopUpdatingLocation()
                
                CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                    let placemark = placemarks?.first
                    
                    // if there's an error or no placemark, then exit
                    
                    guard error == nil && placemark != nil else {
                        print(error!)
                        return
                    }
                    
                    let city = placemark?.locality ?? ""
                    let state = placemark?.administrativeArea ?? ""
                    
                    self.usersLocation = ("\(city), \(state)")
                    print("Kullanıcı burada \(self.usersLocation)")
                    HomeViewController.userCurrentCity = state
                    self.getDatasAndSetObject(city: state)
                    self.titleLabel.text = state
                }
    }
}

