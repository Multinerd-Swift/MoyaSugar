import Moya

public class RequestData {
    let body: Codable?
    let queryParams: [String: Any]
    
    public init(body: Codable? = nil, queryParams: [String: Any] = [:]) {
        self.body = body
        self.queryParams = queryParams
    }
}
