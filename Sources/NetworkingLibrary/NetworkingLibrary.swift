// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public protocol NeworkingService {
    func getNewsFrom(page: Int, complition: @escaping @Sendable (NewsResponseData?, Error?) -> Void)
}

final public class NetworkService: NeworkingService {
    
    public init() {}
    
    public func getNewsFrom(page: Int, complition: @escaping @Sendable (NewsResponseData?, Error?) -> Void) {
      let urlString = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=e43d9a74a6a143bfbfb545869a529d4b&pageSize=10&page=\(page)"

        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            if let error {
                print(error)
            }
            
            guard let response = response as? HTTPURLResponse else {
                complition(nil, CostumErrors.wrongResponse)
                return
            }
            
            guard (200...300).contains(response.statusCode) else {
                complition(nil, CostumErrors.statusCode)
                return
            }
            
            guard let data else {
                complition(nil, CostumErrors.noData)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let newsResponseData = try decoder.decode(NewsResponseData.self, from: data)
                DispatchQueue.main.async {
                    complition(newsResponseData, nil)
                }
            } catch {
                print(error.localizedDescription)
            }
        }).resume()
    }

}

enum CostumErrors: Error {
    case wrongResponse
    case statusCode
    case noData
}

