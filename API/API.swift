//
//  API.swift
//  sparkle
//
//  Created by  ohayoukenchan on 2020/06/11.
//  Copyright © 2020 Takano Kenta. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import SwiftyBeaver
import SparkleClient

let logger = SwiftyBeaver.self

public struct Response<T: Codable> {
    public let content: T
    public let urlRequest: URLRequest
}

public struct NoContent: Codable {}

// MARK: - For AccessToken
public typealias AccessToken = String
extension RequestBuilder where T: Decodable {
    fileprivate func addAuthorizationHeader(_ accessToken: AccessToken) {
        _ = self.addHeader(name: "Authorization", value: "token \(accessToken)")
    }
}

public extension JSONDataEncoding {
    init() {
        self.init()
    }
}

let a: ParameterEncoding = JSONDataEncoding()


public extension AlamofireRequestBuilder {
    func makeDataRequest() -> DataRequest {
        let mannger = createSessionManager()
        let headers = buildHeaders()
        let encoding: ParameterEncoding = isBody ? JSONDataEncoding() : URLEncoding()
        let xMethod = Alamofire.HTTPMethod(rawValue: method)!
        return makeRequest(manager: mannger, method: xMethod, encoding: encoding, headers: headers)
    }
}

// @see https://github.com/dduan/cURLLook/blob/master/cURLLook/NSURLRequestCURLRepresentation.swift
import Foundation

extension URLRequest {
    /*
     Convenience property, the value of calling `cURLRepresentation()` with no arguments.
     */
    public var cURLString: String {
        return cURLRepresentation()
    }

    /*
     cURL (http://http://curl.haxx.se) is a commandline tool that makes network requests. This method serializes a `NSURLRequest` to a cURL
     command that performs the same HTTP request.
     - Parameter session:    *optional* the `NSURLSession` this NSURLRequest is being used with. Extra information from the session such as
     cookies and credentials may be included in the result.
     - Parameter credential: *optional* the credential to include in the result. The value of `session?.configuration.URLCredentialStorage`,
     when present, would override this argument.
     - Returns:              a string whose value is a cURL command that would perform the same HTTP request this object represents.
     */
    public func cURLRepresentation(withURLSession session: URLSession? = nil, credential: URLCredential? = nil) -> String {
        var components: [String] = ["curl"]
        let URL = self.url
        if let httpMethod = httpMethod {
            components.append("-X \(String(describing: httpMethod))")
        }

        if let session = session, session.configuration.httpShouldSetCookies {
            if let cookieStorage = session.configuration.httpCookieStorage,
                let cookies: [HTTPCookie] = cookieStorage.cookies(for: URL!), cookies.isEmpty == false {
                let string = cookies.reduce("") { (initialResult: String, nextPartialResult: HTTPCookie) -> String in
                    return "\(initialResult)\(nextPartialResult.name)=\(nextPartialResult.value);"
                }
                let index = string.index(before: string.endIndex)
                let prefix = String(describing: string.prefix(upTo: index))
                components.append("-b \"\(prefix)\"")
            }
        }

        if let headerFields = self.allHTTPHeaderFields {
            for (field, value) in headerFields {
                if field == "Cookie" { continue }
                if value.contains("gzip") { continue }
                components.append("-H \"\(field): \(value)\"")
            }
        }

        if let session = session, let additionalHeaders = session.configuration.httpAdditionalHeaders as? [String: String] {
            for (field, value) in additionalHeaders {
                if field == "Cookie" { continue }
                components.append("-H \"\(field): \(value)\"")
            }
        }

        if let HTTPBodyData = httpBody,
            let HTTPBody = NSString(data: HTTPBodyData, encoding: String.Encoding.utf8.rawValue) {
            let escapedBody = HTTPBody.replacingOccurrences(of: "\"", with: "\\\"")
            components.append("-d \"\(escapedBody)\"")
        }

        if let URL = URL {
            components.append("\"\(URL.absoluteString)\"")
        }
        return components.joined(separator: " \\\n\t")
    }
}


#if DEBUG
extension AlamofireRequestBuilder {
    func createURLRequest() -> URLRequest? {
        let encoding: ParameterEncoding = isBody ? JSONDataEncoding() : URLEncoding()
        guard let originalRequest = try? URLRequest(url: URLString, method: HTTPMethod(rawValue: method)!, headers: buildHeaders()) else { return nil }
        return try? encoding.encode(originalRequest, with: parameters)
    }

    public var cURLString: String {
        return createURLRequest()?.cURLString ?? ""
    }
}
#endif

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// MARK: - SparkleClient.PhrasesAPI
///////////////////////////////////////////////////////////////////////////////////////////////////////////

extension SparkleClient.PhrasesAPI {
    public class func phrasesGetSingle() -> Single<Response<[Phrase]>> {
        let rb = getPhrasesGetWithRequestBuilder()
        return requestAsSingle(requestBuilder: rb)
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// MARK: - SparkleClient.BookAPI
///////////////////////////////////////////////////////////////////////////////////////////////////////////

extension SparkleClient.BooksAPI {
    public class func booksGetSingle() -> Single<Response<[Book]>> {
        let rb = getBooksGetWithRequestBuilder()
        //let rb = userGetWithRequestBuilder()
        //rb.addAuthorizationHeader(<#AccessToken#>)
        return requestAsSingle(requestBuilder: rb)
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// MARK: - GitHubAPI.DefaultAPI
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

extension SparkleClient.UsersAPI {
//    public class func publicReposGetSingle(perPage: Int) -> Single<Response<[GitHubAPI.PublicRepo]>> {
//        let rb = repositoriesGetWithRequestBuilder(perPage: perPage)
//        return requestAsSingle(requestBuilder: rb)
//    }
//
//    public class func userReposGetSingle(accessToken: AccessToken) -> Single<Response<[GitHubAPI.Repo]>> {
//        let rb = userReposGetWithRequestBuilder()
//        rb.addAuthorizationHeader(accessToken)
//        return requestAsSingle(requestBuilder: rb)
//    }
//
//    public class func reposOwnerRepoGetSingle(owner: String, repo: String) -> Single<Response<GitHubAPI.Repo>> {
//        let rb = reposOwnerRepoGetWithRequestBuilder(owner: owner, repo: repo)
//        return requestAsSingle(requestBuilder: rb)
//    }
//
//    public class func reposOwnerRepoAuthenticatedGetSingle(accessToken: AccessToken, owner: String, repo: String) -> Single<Response<GitHubAPI.Repo>> {
//        let rb = reposOwnerRepoGetWithRequestBuilder(owner: owner, repo: repo)
//        rb.addAuthorizationHeader(accessToken)
//        return requestAsSingle(requestBuilder: rb)
//    }
//
    public class func userGetSingle(accessToken: AccessToken) -> Single<Response<User>> {
        let rb = getUserGetWithRequestBuilder()
        //let rb = userGetWithRequestBuilder()
        rb.addAuthorizationHeader(accessToken)
        return requestAsSingle(requestBuilder: rb)
    }
//
//    public class func publicUserGetSingle(username: String) -> Single<Response<PublicUser>> {
//        let rb = usersUsernameGetWithRequestBuilder(username: username)
//        return requestAsSingle(requestBuilder: rb)
//    }
//
//    public class func reposOwnerRepoReadmeGetSingle(accessToken: AccessToken?, owner: String, repo: String) -> Single<Response<GitHubAPI.Readme>> {
//        let rb = reposOwnerRepoReadmeGetWithRequestBuilder(owner: owner, repo: repo)
//        if let accessToken = accessToken {
//            rb.addAuthorizationHeader(accessToken)
//        }
//        return requestAsSingle(requestBuilder: rb)
//    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Private Helper Methods
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Single<T> -------------------------------------------------------------------------------------------------
private func requestAsSingle<T: Decodable>(requestBuilder rb: RequestBuilder<T>) -> Single<Response<T>> {
    return RxSwift.Single.create { observer -> Disposable in
        guard let rb = rb as? AlamofireRequestBuilder<T>, let urlRequest = rb.makeDataRequest().request else {
            observer(.error(APIDomainError.unreachable))
            return Disposables.create()
        }

        loggerInfo(urlRequest)


        rb.execute { (result) -> Void in
            switch result {
            case .success(let response):
                if let body = response.body {
                    let response = Response(content: body, urlRequest: urlRequest)
                    observer(.success(response))
                } else {
                    observer(.error(APIDomainError.unreachable))
                }
            case .failure(let error):
                loggerError(urlRequest, error: error)
                if let responseError = (error as? SparkleClient.ErrorResponse)?.responseError {
                    if let networkError = responseError.networkError {
                        observer(.error(APIDomainError.network(error: networkError)))
                    } else {
                        observer(.error(APIDomainError.response(error: responseError)))
                    }
                } else {
                    observer(.error(APIDomainError.unknownError(error: error)))
                }
            }
        }
        return Disposables.create()
    }
}

// MARK: - Single<NoContent> -----------------------------------------------------------------------------------------
private func requestAsSingleNoContent(requestBuilder rb: RequestBuilder<Void>) -> Single<Response<NoContent>> {
    return RxSwift.Single.create { observer -> Disposable in
        guard let rb = rb as? AlamofireRequestBuilder<Void>, let urlRequest = rb.makeDataRequest().request else {
            observer(.error(APIDomainError.unreachable))
            return Disposables.create()
        }

        loggerInfo(urlRequest)

        rb.execute { (result) -> Void in
            switch result {
            case .success(let response):
                if response.statusCode == noContent { // For 204 NoContent
                    let response = Response(content: NoContent(), urlRequest: urlRequest)
                    observer(.success(response))
                } else {
                    observer(.error(APIDomainError.unreachable))
                }
            case .failure(let error):
                loggerError(urlRequest, error: error)
                if let responseError = (error as? SparkleClient.ErrorResponse)?.responseError {
                    if let networkError = responseError.networkError {
                        observer(.error(APIDomainError.network(error: networkError)))
                    } else {
                        observer(.error(APIDomainError.response(error: responseError)))
                    }
                } else {
                    observer(.error(APIDomainError.unknownError(error: error)))
                }
            }
        }
        return Disposables.create()
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// MARK: - Logger
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
private func loggerInfo(_ urlRequest: URLRequest) {
    #if DEBUG
    logger.info("\n⚡️ \(urlRequest.cURLString) | jq .")
    #endif
}

private func loggerError(_ urlRequest: URLRequest, error: Error) {
    #if DEBUG
    logger.error("\(error)\n🚫 \(urlRequest.cURLString) | jq .")
    #endif
}

