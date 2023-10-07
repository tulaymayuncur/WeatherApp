//
//  ViewController.swift
//  WeatherApp
//
//  Created by Tülay MAYUNCUR on 7.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var labelSehirSecin: UILabel!
    
    @IBOutlet weak var textFieldSehir: UITextField!
    
    var weatherData: WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImageView.layer.cornerRadius = logoImageView.frame.size.width / 2
        logoImageView.clipsToBounds = true
        logoImageView.layer.borderWidth = 2
        logoImageView.layer.borderColor = UIColor.white.cgColor
        
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "bg")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = view.bounds
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
    }
    
    @IBAction func AraButton(_ sender: Any) {
        if let city = textFieldSehir.text {
            let apiUrl = "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=\(city)"
            // API çağrısını yapmak için yeni bir fonksiyon oluşturun ve bu URL'yi kullanın
            fetchWeatherData(apiUrl: apiUrl)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let destinationVC = segue.destination as? WeatherDetailVC {
                // Burada geçiş verisini veya diğer hazırlıkları yapabilirsiniz.
                destinationVC.weatherData = self.weatherData
            }
        }
    }
    
    func fetchWeatherData(apiUrl: String) {
        
        // API URL'sini oluşturun
        if let url = URL(string: apiUrl){
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("apikey 0NhzdC4EUi8CGIofVoldl7:0DzHv36yQ9Gjz5KKMIzyaz", forHTTPHeaderField: "authorization")
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            
            // URL'den veriyi çekin
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Hata oluştu: \(error.localizedDescription)")
                    return
                }
                
                if let data = data {
                    do {
                        let weatherData = try JSONDecoder().decode(WeatherModel.self, from: data)
                        self.weatherData = weatherData // Veriyi özelliğe ata
                        
                        for result in weatherData.result {
                            
                            print("City: \(weatherData.city)")
                            print("Icon: \(result.icon)")
                            print("Status: \(result.status)")
                            print("Degree: \(result.degree)")
                        }
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "toDetail", sender: self)
                        }
                    } catch {
                        print("JSON çözme hatası: \(error.localizedDescription)")
                    }
                }
            }.resume()
        }
    }
}
