
import Foundation
public enum APIError: Error {
    case wrongStatusError(status: Int)
    case urlSessionError(Error)
    case parseError(Error)
}

