//
//  Weather.swift
//  WeatherApp
//
//  Created by Metehan Karadeniz on 12.07.2023.
//
import Foundation
struct WeatherResponse: Decodable {
    let result: [WeatherData]
}
struct WeatherData: Decodable {
    let date: String
    let day: String
    let icon: String
    let description: String
    let status: String
    let degree: String
    let min: String
    let max: String
    let night: String
    let humidity: String
}
