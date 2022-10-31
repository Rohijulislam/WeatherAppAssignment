
import UIKit
import CoreLocation
import SDWebImage
import SVProgressHUD

class ForecastViewController: UIViewController {
    
    @IBOutlet var locationLable: UILabel!
    @IBOutlet var templabel: UILabel!
    @IBOutlet var weatherImageView: UIImageView!
    @IBOutlet var weatherDescription: UILabel!
    @IBOutlet var sunsetLabel: UILabel!
    @IBOutlet var sunriseLabel: UILabel!
    @IBOutlet var cloudLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    private var forecastList: [[Forecast]] = [[]] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CoreLocationService.sharedInstance.delegate = self
        CoreLocationService.sharedInstance.authorizeUser()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ForecastTableViewCell.getNib(), forCellReuseIdentifier: Constants.FORECAST_TABLE_CELL_ID)
        CommonUtility.sharedInstance.updateProgressView()
    }
    
    
    func updateUI(city: City, forecast: Forecast) {
        SVProgressHUD.dismiss()
        locationLable.text = city.name
        templabel.text = "\(forecast.main.temp) °C"
        weatherDescription.text = forecast.weather.first?.weatherDescription ?? ""
        sunriseLabel.text = "Sunrise : \(city.sunriseTime())"
        sunsetLabel.text = "Sunset : \(city.sunsetTime())"
        weatherImageView.sd_setImage(with: forecast.weather.first?.getIconURL())
        humidityLabel.text = "Humidity : \(forecast.main.humidity)%"
        cloudLabel.text = "Cloud : \(forecast.clouds.all)%"
    }
    
    func updateData(data: ForecastResult) {
        DispatchQueue.main.async {
            self.title = "\(data.city.name), \(data.city.country)"
            self.updateUI(city: data.city, forecast: data.list.first!)
            self.forecastList = data.sortedForecastsByDays()
        }
    }
    
    func fetchForecastData(location: CLLocation) {
        if forecastList.first?.isEmpty != false {
            SVProgressHUD.show()
        }
        
        NetworkServiceManager.sharedInstance.fetchData(lat: "\(location.coordinate.latitude)", long: "\(location.coordinate.longitude)") { (res) in
            
            switch res {
            case .success(let data):
                self.updateData(data: data)
            case .failure(let error):
                DispatchQueue.main.async {
                    CommonUtility.sharedInstance.showAlert(title: "Error!", msg: error.localizedDescription, controller: self)
                }
            }
        }
    }
}

// MARK:- CoreLocationServiceDelegate
extension ForecastViewController: CoreLocationServiceDelegate {
    func locationDidUpdated(location: CLLocation) {
        self.fetchForecastData(location: location)
    }
    
    func locationDidFailure(error: NSError) {
        CommonUtility.sharedInstance.showAlert(title:"Error!", msg: error.userInfo["message"] as? String ?? "", controller: self)
    }
    
}

// MARK:- UITableViewDelegate, UITableViewDataSource
extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return forecastList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard !forecastList.isEmpty, let first = forecastList[section].first else {
            return nil
        }
        return CommonUtility.sharedInstance.dateInfo(date: first.getDate())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastList[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.FORECAST_TABLE_CELL_ID) as? ForecastTableViewCell else {
            return UITableViewCell()
        }
        let data = forecastList[indexPath.section][indexPath.row]
        cell.configureCell(forecast: data)
        cell.accessoryType = .disclosureIndicator
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = forecastList[indexPath.section][indexPath.row]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let controller = storyBoard.instantiateViewController(withIdentifier: Constants.FORECAST_DETAILS_VC_ID) as? ForecastDetailsViewController {
            controller.forecast = data
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}
