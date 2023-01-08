import Foundation
import FoundationNetworking

class DataHandler {
    let apiURL = "https://api.twelvedata.com"
    let apiKey: String
    let apiKeyFileName = "twelvedata.com-api-key"

    init() {
        do {
            apiKey = try String(contentsOfFile: apiKeyFileName)
        } catch {
            print("Error reading API key from file: \(error)")
            exit(1)
        }
    }

    func getCryptocurrenciesList() -> [String] {
        let url = URL(string: "\(apiURL)/cryptocurrencies?apikey=\(apiKey)")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        let cryptocurrencies = json["data"] as! [[String: Any]]
        var result = [String]()
        for cryptocurrency in cryptocurrencies {
            result.append(cryptocurrency["symbol"] as! String)
        }
        return result
    }

    func getCryptocurrenciesTodayPrice(cryptocurrencies: [String]) -> [String: String] {
        let url = URL(string: "\(apiURL)/time_series?symbol=\(cryptocurrencies.joined(separator: ","))&interval=1day&apikey=\(apiKey)")
        print(url!)
        let data = try! Data(contentsOf: url!)
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        var prices: [String: String] = [:]
        for cryptocurrency in cryptocurrencies {
            let lastPrice = ((json[cryptocurrency] as! [String: Any])["values"] as! [[String: Any]]).last!["close"] as! String
            prices[cryptocurrency] = lastPrice
        }
        return prices
    }
}