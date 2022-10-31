
import Foundation
import CoreLocation


protocol CoreLocationServiceDelegate {
    func locationDidUpdated(location: CLLocation)
    func locationDidFailure(error: NSError)
}


final class CoreLocationService: NSObject {
    
    private override init() {}
    static let sharedInstance = CoreLocationService()
    private lazy var locationManager = CLLocationManager()
    var delegate: CoreLocationServiceDelegate?
    
    //MARK:- Authorize User
    func authorizeUser() {
        guard CLLocationManager.locationServicesEnabled() else {
            self.callErrorWithMessage(message: "Location service is notenabled.")
            return
        }
        
        setupLocationManager()
        checkLocationAuth()
    }
    
    func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        // Update user current location in background
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
    }
    
    func checkLocationAuth() {
        switch  CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            updateUserLocation()
            break
        case .denied:
            // when the user denies the location access
            break
        case .notDetermined:
            // before user providing the app access
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            //parental controls may restrict uses to provide location accees
            break
        case .authorizedAlways:
            //do not use this unless critical
            break
        @unknown default:
            break
        }
    }
    
    //MARK:- Update User Location
    func updateUserLocation() {
        locationManager.startUpdatingLocation()
    }
    
    private func callErrorWithMessage(message: String) {
        let error = NSError(domain: "geolocation.location", code: -1000, userInfo: ["message": message])
        self.delegate?.locationDidFailure(error: error)
    }
    
}

//MARK:- CLLocationManager Delegate
extension CoreLocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        debugPrint("Latitude: \(locations[0].coordinate.latitude) -- Longitude: \(locations[0].coordinate.longitude)")
        delegate?.locationDidUpdated(location: locations[0])
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            self.authorizeUser()
            return
        } else if status == .denied || status == .restricted {
            self.callErrorWithMessage(message: "Please authorize permission of location. Otherwise the app might not work properly.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to access your location.")
        delegate?.locationDidFailure(error: error as NSError)
    }
    
}
