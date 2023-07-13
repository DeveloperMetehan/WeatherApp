//
//  UIImageViewExtension.swift
//  WeatherApp
//
//  Created by Metehan Karadeniz on 12.07.2023.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(imageUrl: String){
        DispatchQueue.main.async {
            self.kf.setImage(with: URL(string: imageUrl))
        }
      
        
    }
    
}
