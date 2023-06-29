public final class AppSetting {
    public static let shared = AppSetting()
    public var enviroment: Enviroment = .mock
    private init(){
    }
}
public enum Enviroment: String {
    case live
    case mock
    case failureMock
}
