//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Metehan Karadeniz on 12.07.2023.
//
import Foundation

class WeatherViewModel {
    static let shared = WeatherViewModel()
    
    var weathers: [WeatherData] = []
    var isDataFetched = false
    
    private init() {}
    
    func fetchWeathers(city: String, completion: @escaping ([WeatherData]) -> Void) {
        if isDataFetched {
            // Veriler zaten önbellekte olduğu için doğrudan döndürüyoruz
            completion(weathers)
            return
        }
        
        // Veriler önbellekte yoksa isteği gerçekleştiriyoruz
        guard let url = URL(string: "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=\(city)") else {
            completion([])
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("apikey 1dnZbUKIA56nwmbnaCVB6v:1xg3dvYPlAnrC9MaqZcLzO", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            // İstek tamamlandığında verileri alıyoruz
            if let error = error {
                print("Error fetching weather data: \(error)")
                completion([])
                return
            }
            
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(WeatherResponse.self, from: data)
                self?.weathers = result.result
                self?.isDataFetched = true // Veriler önbelleğe alındı
                completion(self?.weathers ?? [])
                print("data fetched")
            } catch let decodingError as DecodingError {
                print("Error decoding JSON: \(decodingError)")
                completion([])
            } catch {
                print("Error decoding JSON: \(error)")
                completion([])
            }
        }
        
        task.resume()
    }
}
