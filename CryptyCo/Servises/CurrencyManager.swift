
import Foundation

protocol ICurrencyManager: AnyObject {
    func loadCurrencyData(completion: @escaping (Result<Double, Error>) -> Void)
}

final class CurrencyManager {
    enum EndPoints {
        static let currencyUrl = "https://www.cbr-xml-daily.ru/daily_json.js"
    }
}

extension CurrencyManager: ICurrencyManager {
    func loadCurrencyData(completion: @escaping (Result<Double, Error>) -> Void) {
        guard let url = URL(string: EndPoints.currencyUrl) else {
            return completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
        }
        let reuqest = URLRequest(url: url)
        let session = URLSession.shared.dataTask(with: reuqest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return completion(.failure(NSError(domain: "No data", code: 1, userInfo: nil))) }
            do {
                let currencyData = try JSONDecoder().decode(CurrencyDTO.self, from: data)
                guard let usdCurrency = currencyData.Valute["USD"] else {
                    return completion(.failure(NSError(domain: "USD currency not found", code: 2, userInfo: nil)))
                }
                completion(.success(usdCurrency.Value))
            } catch let error {
                completion(.failure(error))
            }
        }
        session.resume()
    }
}
