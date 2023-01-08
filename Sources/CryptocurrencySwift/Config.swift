import Foundation

class Config: Codable { 
    public var favoriteCurrencies: [String]
    public var username: String

    init(favoriteCurrencies: [String], username: String) {
        self.favoriteCurrencies = favoriteCurrencies
        self.username = username
    }
}

class ConfigMan {
    private let file: String = "cryptocurrency-swift.json"
    private let fileManager: FileManager = FileManager.default
    private let decoder: JSONDecoder = JSONDecoder()
    private let encoder: JSONEncoder = JSONEncoder()
    private let defaultConfig: Config = Config(favoriteCurrencies: ["BTC/USD", "ETH/USD", "USDT/USD"], username: "John Doe")

    init() {
        if !fileManager.fileExists(atPath: file) {
            save(config: defaultConfig)
        }
    }

    func save(config: Config) {
        do {
            let data = try encoder.encode(config)
            fileManager.createFile(atPath: file, contents: data, attributes: nil)
        } catch {
            print("Error saving config: \(error)")
        }
    }

    func load() -> Config {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: file))
            return try decoder.decode(Config.self, from: data)
        } catch {
            print("Error loading config: \(error)")
            return defaultConfig
        }
    }
}