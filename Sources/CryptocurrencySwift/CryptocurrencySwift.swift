
@main
public struct CryptocurrencySwift {
    static let configMan = ConfigMan()

    static let viewProfileMenu = Menu(title: "Profile", items: [
        MenuItem(title: "Show Username") {
            print("Username: \(configMan.load().username)")
        },
        MenuItem(title: "Change Username") {
            print("Enter new username: ", terminator: "")
            let newUsername = readLine() ?? ""
            let config = configMan.load()
            config.username = newUsername
            configMan.save(config: config)
        }
    ])

    static let viewCryptocurrenciesMenu: Menu = Menu(title: "Cryptocurrencies", items: [
        MenuItem(title: "Show Available Currencies") {
            let cryptocurrencies: [String]
            do {
                cryptocurrencies = try DataHandler().getCryptocurrenciesList()
            } catch {
                print("Error getting cryptocurrencies list: \(error)")
                return
            }
            for cryptocurrency in cryptocurrencies {
                print(cryptocurrency, terminator: " ")
            }
            print()
        },
        MenuItem(title: "Show Currency Details") {
            print("Enter currency: ", terminator: "")
            let currency = readLine() ?? ""
            let availableCurrencies: [String]
            do {
                availableCurrencies = try DataHandler().getCryptocurrenciesList()
            } catch {
                print("Error getting cryptocurrencies list: \(error)")
                return
            }
            if !availableCurrencies.contains(currency) {
                print("Invalid currency")
                return
            }
            print("Enter start date (YYYY-MM-DD): ", terminator: "")
            let startDate = readLine() ?? ""
            print("Enter end date (YYYY-MM-DD): ", terminator: "")
            let endDate = readLine() ?? ""
            let details: [String: String]
            do {
                details = try DataHandler().getCryptocurrencyDetails(currency: currency, startDate: startDate, endDate: endDate)
            } catch {
                print("Error getting cryptocurrency details: \(error)")
                return
            }
            print(currency)
            for (date, price) in details {
                print("\(date): \(price)")
            }
        },
        MenuItem(title: "Show Favorite Currencies") {
            let favoriteCurrencies = configMan.load().favoriteCurrencies
            let prices: [String: String]
            do {
                prices = try DataHandler().getCryptocurrenciesTodayPrice(cryptocurrencies: favoriteCurrencies)
            } catch {
                print("Error getting cryptocurrencies today price: \(error)")
                return
            }
            for (currency, price) in prices {
                print("\(currency): \(price)")
            }
        },
        MenuItem(title: "Add Favorite Currency") {
            print("Enter new favorite currency: ", terminator: "")
            let newFavoriteCurrency = readLine() ?? ""
            let availableCurrencies: [String]
            do {
                availableCurrencies = try DataHandler().getCryptocurrenciesList()
            } catch {
                print("Error getting cryptocurrencies list: \(error)")
                return
            }
            if !availableCurrencies.contains(newFavoriteCurrency) {
                print("Invalid currency")
                return
            }
            var config = configMan.load()
            config.favoriteCurrencies.append(newFavoriteCurrency)
            configMan.save(config: config)
        },
        MenuItem(title: "Remove Favorite Currency") {
            print("Enter favorite currency to remove: ", terminator: "")
            let favoriteCurrencyToRemove = readLine() ?? ""
            var config = configMan.load()
            config.favoriteCurrencies.removeAll { $0 == favoriteCurrencyToRemove }
            configMan.save(config: config)
        }
    ])

    static let mainMenu = Menu(title: "Welcome to Cryptocurrency Swift!", items: [
        MenuItem(title: "View Cryptocurrencies") {
            viewCryptocurrenciesMenu.run()
        },
        MenuItem(title: "View Profile") {
            viewProfileMenu.run()
        },
    ])

    public static func main() {
        mainMenu.run()
    }
}
