import Foundation

public protocol CommandType {
  var commandValues: [String] { get }
}

extension CommandType {
  public var commandString: String {
    return commandValues.joined(separator: " ")
  }
}

public protocol OptionType {

  var commandValues: [String] { get }
}

public enum Git {

  public struct Init : CommandType {

    public let commandValues: [String]

    public init() {
      commandValues = ["git", "init"]
    }
  }

  public struct Commit : CommandType {

    public let commandValues: [String]

    public init() {
      commandValues = ["git", "commit"]
    }
  }

  public struct Pull : CommandType {

    public let commandValues: [String]

    public init() {
      commandValues = ["git", "pull"]
    }
  }

  public struct Push : CommandType {

    public let commandValues: [String]

    public init() {
      commandValues = ["git", "push"]
    }
  }

  public struct Fetch : CommandType {

    public enum Option : OptionType {

      case verbose

      public var commandValues: [String] {
        switch self {
        case .verbose:
          return ["-v"]
        }
      }
    }

    public let commandValues: [String]

    public init(group: String, options: [Option]) {

      commandValues = ["git", "fetch"] + options.joinedCommand() + [group]
    }
  }
}

extension Array where Element : OptionType {

  fileprivate func joinedCommand() -> [String] {
    return flatMap { $0.commandValues }
  }
}
