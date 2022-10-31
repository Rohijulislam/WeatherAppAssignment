
import UIKit

class ForecastDetailsViewController: UIViewController {
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var weatherImageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var windLabel: UILabel!
    @IBOutlet var cloudLabel: UILabel!
    @IBOutlet var weatherDescriptionContainerView: UIView!
    
    var forecast: Forecast? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
    }
    
    func setupUI() {
        weatherDescriptionContainerView.layer.cornerRadius = weatherDescriptionContainerView.bounds.size.height / 2.0
    }
    
    func updateUI() {
        if let forecast = forecast {
            self.timeLabel.text = CommonUtility.sharedInstance.getTime(since1970: Double(forecast.dt))
            weatherImageView.sd_setImage(with: forecast.weather.first?.getIconURL())
            descriptionLabel.text = "\(forecast.weather.first?.weatherDescription ?? "")"
            tempLabel.text = "\(forecast.main.temp) °C"
            humidityLabel.text = "\(forecast.main.humidity)%"
            cloudLabel.text = "\(forecast.clouds.all)%"
            windLabel.text = "\(((forecast.wind.speed * 60) / 1000).truncate(places: 2)) km/h"
        }
    }
    
    @IBAction func openSourceBtnTapped(_ sender: Any) {
        if let url = URL(string: Constants.WEATHER_SOURCE_URL), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                debugPrint("Open url : \(success)")
            })
        }
    }
}
