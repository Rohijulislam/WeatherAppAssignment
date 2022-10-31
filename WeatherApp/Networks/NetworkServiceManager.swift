
import Foundation
import Alamofire

class NetworkServiceManager: NSObject {
    private override init() {}
    static let sharedInstance = NetworkServiceManager()
    
    func fetchData(lat: String, long: String, completion: @escaping (Result<ForecastResult, APIError>) -> Void) {
        let urlString = Constants.FORECAST_URL
        let parameters: [String : String] = [
            "lat": lat,
            "lon" : long,
            "units": "metric",
            Constants.API_APP_ID:Constants.API_KEY
        ]
        
        AF.request(urlString , method: .get,parameters: parameters, encoding: URLEncoding(destination: .queryString))
            .validate().responseDecodable(of: ForecastResult.self) {
                (response) in
                
                if let res = response.value {
                    completion(Result.success(res));
                    debugPrint(res)
                } else if let error = response.error {
                    completion(Result.failure(self.errorHandling(error: error)))
                } else {
                    completion(Result.failure(.responseUnsuccessful))
                }
                
            }
    }
    
    
    func errorHandling(error: AFError) -> APIError {
        switch error {
        case .invalidURL(let url):
            return .invalidURL(urlString: "\(url)")
        case .parameterEncodingFailed(_):
            return .requestFailed;
        case .responseValidationFailed(_):
            return .responseUnsuccessful;
        case .responseSerializationFailed(_):
            return .jsonParsingFailure;
        default:
            return .responseUnsuccessful;
        }
    }
}

