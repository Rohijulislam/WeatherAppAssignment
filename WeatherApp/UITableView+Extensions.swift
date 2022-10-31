
import UIKit

extension UITableView {
    
    func setDeafultViewOnEmpty(_ message: String)  {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.bounds.size.width, height: self.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 20.0)
        self.backgroundView = messageLabel
        messageLabel.sizeToFit()
        self.separatorStyle = .none
    }
    
    func setActualView() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
