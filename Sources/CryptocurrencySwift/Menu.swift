import Glibc

class Menu {
    public let title: String
    public var items: [MenuItem]
    public let prompt: String

    public init(title: String, items: [MenuItem], prompt: String = "Enter your choice: ") {
        self.title = title
        self.items = items
        self.items.append(MenuItem(title: "Back") {
        })
        self.prompt = prompt
    }

    public func run() {
        while true {
            system("clear")
            print(title)
            for (index, item) in items.enumerated() {
                print("\(index + 1). \(item.title)")
            }
            print(prompt, terminator: "")
            let choice: String = readLine() ?? ""
            if let index = Int(choice), index > 0, index <= items.count {
                if index == items.count {
                    break
                }
                items[index - 1].action()
            } else {
                print("Invalid choice. Please try again.")
            }
            print("Press enter to continue...", terminator: "")
            _ = readLine()
        }
    }
}