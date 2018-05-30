import Foundation
import Moya
import RxSwift

extension Response {
    fileprivate func cast<T : Decodable>(_ to: T.Type, wrapped: Bool) -> T? {
        let obj: T?

        if wrapped {
            obj = try? JSONDecoder().decode(ResponseWrapper<T>.self, from: self.data).data
        } else {
            obj = try? JSONDecoder().decode(T.self, from: self.data)
        }
        
        return obj
    }
}


extension PrimitiveSequenceType where TraitType == SingleTrait, ElementType == Response {
    public func subscribe<T: Decodable>(for: T.Type, wrapped: Bool, onSuccess: ((T) -> Void)? = nil, onError: ((Swift.Error) -> Void)? = nil) -> Disposable {
        return self.subscribe(onSuccess: { res in
            // The smallest json is 2 char: {}
            if res.data.count < 2 {
                onError?(CastError.emptyResponse)
                return
            }
            if let castable = res.cast(T.self, wrapped: wrapped) {
                onSuccess?(castable)
            } else {
                if let msg = String(data: res.data, encoding: .utf8) {
                    onError?(CastError.cannotCast(msg: msg))
                } else {
                    onError?(CastError.cannotCast(msg: ""))
                }
                
            }
        }, onError: onError)
    }
}



public enum CastError : Swift.Error {
    case cannotCast(msg: String)
    case emptyResponse
}

extension CastError {
    /// A textual representation of `self`, suitable for debugging.
    public var debugDescription: String {
        switch self {
        case .cannotCast( _):
            return "Downloaded content can't be converted to User type"
        case .emptyResponse:
            return "Response is empty"
        }
    }
}

struct ResponseWrapper<T>: Decodable where T: Decodable {
    var data: T
}

