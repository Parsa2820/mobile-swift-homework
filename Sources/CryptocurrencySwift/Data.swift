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

    func getCryptocurrenciesList() throws -> [String] {
        let url = URL(string: "\(apiURL)/cryptocurrencies?apikey=\(apiKey)")
#if DEV
        print("URL: \(url!)")
#endif
        let data = try Data(contentsOf: url!)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        let cryptocurrencies = json["data"] as! [[String: Any]]
        var result = [String]()
        for cryptocurrency in cryptocurrencies {
            result.append(cryptocurrency["symbol"] as! String)
        }
        return result
    }

    func getCryptocurrenciesTodayPrice(cryptocurrencies: [String]) throws -> [String: String] {
        var prices: [String: String] = [:]
        let url = URL(string: "\(apiURL)/time_series?symbol=\(cryptocurrencies.joined(separator: ","))&interval=1day&apikey=\(apiKey)")
#if DEV
        print("URL: \(url!)")
#endif
        let data = try Data(contentsOf: url!)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        for cryptocurrency in cryptocurrencies {
            let lastPrice = ((json[cryptocurrency] as! [String: Any])["values"] as! [[String: Any]]).last!["close"] as! String
            prices[cryptocurrency] = lastPrice
        }
        return prices
    }

    func getCryptocurrencyDetails(currency: String, startDate: String, endDate: String) throws -> [String: String] {
        var result: [String: String] = [:]
        let url = URL(string: "\(apiURL)/time_series?symbol=\(currency)&interval=1day&start_date=\(startDate)&end_date=\(endDate)&apikey=\(apiKey)")
#if DEV
        print("URL: \(url!)")
#endif
        let data = try Data(contentsOf: url!)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        let values = json["values"] as! [[String: Any]]
        for value in values {
            result[value["datetime"] as! String] = (value["close"] as! String)
        }
        return result
    }
}