
import UIKit

class ForecastTableViewCell: UITableViewCell {
    @IBOutlet var weatherImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    
    static func getNib() -> UINib {
        return UINib(nibName: "ForecastTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(forecast : Forecast) {
        weatherImageView.sd_setImage(with: forecast.weather.first?.getIconURL())
        titleLabel.text = CommonUtility.sharedInstance.getTime(since1970: Double(forecast.dt))
        descriptionLabel.text = "\(forecast.weather.first?.weatherDescription ?? ""), \(forecast.main.temp) °C"
    }
    
}
