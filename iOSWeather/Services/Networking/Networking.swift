//
//  Networking.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 14.01.2022.
//

import Foundation


public protocol Networking {
    
    func request<Request: NetworkRequest>(
        _ request: Request,
        completion: @escaping (Result<Request.NetworkResponse, Error>) -> Void)
    
}

extension Networking {
    
    public func request<Request: NetworkRequest>(_ request: Request,
                                                 completion: @escaping (Result<Request.NetworkResponse, Error>) -> Void) {
        
        guard var urlComponent = URLComponents(string: request.url) else {
            let error = NSError(
                domain: ResponseError.invalidEndPoint.description,
                code: 404,
                userInfo: nil
            )
            return completion(.failure(error))
        }
        
        var queryItems: [URLQueryItem] = []
        
        request.queries.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            urlComponent.queryItems?.append(urlQueryItem)
            queryItems.append(urlQueryItem)
        }
        
        urlComponent.queryItems = queryItems
        guard let url = urlComponent.url else {
            let error = NSError(
                domain: ResponseError.invalidEndPoint.description,
                code: 404,
                userInfo: nil
            )
            return completion(.failure(error))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                return completion(.failure(error))
            }
            guard let response = response as? HTTPURLResponse else  {
                let error = NSError(domain: ResponseError.badResponse.description,
                                    code: 400, userInfo: nil)
                completion(.failure(error))
                return
            }
            guard response.statusOK else {
                let error = NSError(domain: ResponseError.badResponse.description,
                               code: response.statusCode,
                               userInfo: nil)
                completion(.failure(error))
                return
            }
            guard let data = data else {
                let error = NSError(domain: ResponseError.nothingToDecode.description,
                                    code: response.statusCode,
                                    userInfo: nil)
                return completion(.failure(error))
                
            }
            
            do {
                try completion(.success(request.decode(data)))
            } catch let error as NSError {
                completion(.failure(error))
            }
        }
        .resume()
    }
}
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public protocol NetworkRequest {
    associatedtype NetworkResponse
    var url: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String] { get }
    var queries: [String: String] { get }
    func decode(_ data: Data) throws -> NetworkResponse
}

extension NetworkRequest {
    var headers: [String: String] { return [:] }
    var queries: [String: String] { [:] }
}

extension NetworkRequest where NetworkResponse: Decodable {
    func decode(_ data: Data) throws -> NetworkResponse {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(NetworkResponse.self, from: data)
    }
}

public enum ResponseError: Error, CustomStringConvertible {
    case nothingToDecode
    case decoding
    case invalidEndPoint
    case invalidResponse
    case badResponse
    
    public var description: String {
        switch self {
        case .decoding:
            return "Failed decoding data"
        case .invalidEndPoint:
            return "Bad url"
        case .invalidResponse:
            return "Could not decode into valid response"
        case.nothingToDecode:
            return "Nothing to decode"
        case .badResponse :
            return "Bad Response"
        }
    
    }

}

extension HTTPURLResponse {
    
    var statusOK: Bool {
        return (200...299).contains(statusCode)
    }
    
}
