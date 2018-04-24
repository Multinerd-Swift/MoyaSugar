import struct Foundation.URL

import Moya

public protocol SugarTargetType: TargetType {
  var url: URL { get }

  /// Returns `Route` which contains HTTP method and URL path information.
  ///
  /// Example:
  ///
  /// ```
  /// var route: Route {
  ///   return .get("/me")
  /// }
  /// ```
  var route: Route { get }
  var parameters: Parameters? { get }
  
  var requestData: RequestData? { get }

}

public extension SugarTargetType {
    
  /// Provides stub data for use in testing.
  var sampleData: Data { return Data() }
    
  public var url: URL {
    return self.defaultURL
  }

  var defaultURL: URL {
    return self.path.isEmpty ? self.baseURL : self.baseURL.appendingPathComponent(self.path)
  }

  public var path: String {
    return self.route.path
  }

  public var method: Moya.Method {
    return self.route.method
  }

  public var task: Task {
    if let data = self.requestData {
        if let body = data.body?.jsonData {
             return .requestCompositeData(bodyData: body, urlParameters: data.queryParams)
        }
    }
    if let parameters = self.parameters {
        return .requestParameters(parameters: parameters.values, encoding: parameters.encoding)
    }
    
    return .requestPlain
  }
}

extension Encodable {
    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }
}
