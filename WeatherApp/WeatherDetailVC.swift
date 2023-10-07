//
//  WeatherDetailVC.swift
//  WeatherApp
//
//  Created by Tülay MAYUNCUR on 7.10.2023.
//

import UIKit

class WeatherDetailVC: UIViewController {
    
    @IBOutlet weak var labelSehir: UILabel!
    @IBOutlet weak var imageViewHavaDurumu: UIImageView!
    
    @IBOutlet weak var LabelDerece: UILabel!
    
    @IBOutlet weak var LabelHavaDurumu: UILabel!
    
    var weatherData : WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let w = self.weatherData {
            
            labelSehir.text = w.city
            LabelDerece.text = "\(w.result[0].degree) °C"
            LabelHavaDurumu.text = w.result[0].status
            
            if let url = URL(string: "\(w.result[0].icon)"){
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.imageViewHavaDurumu.image = UIImage(data: data!)
                    }
                }
            }

            let backgroundImageView = UIImageView()
            backgroundImageView.image = UIImage(named: "bg")
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.frame = view.bounds
            view.addSubview(backgroundImageView)
            view.sendSubviewToBack(backgroundImageView)
            
            
        }
    }
}
