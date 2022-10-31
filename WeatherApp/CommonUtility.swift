
import Foundation
import UIKit
import SVProgressHUD

class CommonUtility: NSObject {
    
    private override init() {}
    static let sharedInstance = CommonUtility()
    
    func updateProgressView() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor.gray.withAlphaComponent(1))
    }
    
    func getTime(since1970: Double) -> String {
        let date = Date(timeIntervalSince1970: since1970)
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
    
    func dateInfo(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "EEEE, dd-MM-yyyy"
        return dateFormatter.string(from: date)
    }
    
    func showAlert(title: String, msg: String, controller: UIViewController) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        controller.present(alert, animated: true, completion: nil)
    }
}
