import Alamofire
import Moya

public class RequestData {
    let body: Codable?
    let queryParams: [String: Any]
    let queryParamsEncoding: Alamofire.ParameterEncoding
    
    public init(body: Codable? = nil, queryParams: [String: Any] = [:], queryParamsEncoding: Alamofire.ParameterEncoding = Alamofire.URLEncoding()) {
        self.body = body
        self.queryParams = queryParams
        self.queryParamsEncoding = queryParamsEncoding
    }
}
