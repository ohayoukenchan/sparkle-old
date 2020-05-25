//
//  SearchAction.swift
//  sparkle
//
//  Created by Takano Kenta on 2018/12/11.
//  Copyright © 2018年 Takano Kenta. All rights reserved.
//

import ReSwift
//import Moya
import ObjectMapper

extension SearchState {
    public static func searchTweets(query: String) -> SearchTweets {
//        _ = MoyaProvider<SearchProvider>()
//            .request(.searchTweets(query: query, maxId: nil)) { event in
//                switch event {
//                case .success(let response):
//                    do {
//                        if let json = try response.mapJSON() as? [String: Any], let statuses = json["statuses"] as? [[String : Any]] {
//                            let tweets = Mapper<Tweet>().mapArray(JSONArray: statuses)
//                            var resultsMaxId: String? = nil
//                            if let lastTweet = tweets.last {
//                                resultsMaxId = lastTweet.id
//                            }
//
//                            store.dispatch(SearchTweetsAction(query: query, results: .success(tweets), maxId: resultsMaxId))
//
//                        }
//                    } catch {
//                        store.dispatch(SearchTweetsAction(query: query, results: .failure(.somethingWentWrong("Parse Error")), maxId: nil))
//                    }
//
//                    break
//                case .failure(let error): store.dispatch(SearchTweetsAction(query: query, results: .failure(.somethingWentWrong(error.localizedDescription)), maxId: nil))
//                    break
//                }
//        }
//
        return SearchTweets()
    }
    
    public static func loadMoreTweets() -> LoadMoreTweets {
        guard let state = store.state, let query = state.searchState.query, let maxId = state.searchState.maxId else { return LoadMoreTweets() }
        
//        _ = MoyaProvider<SearchProvider>()
//            .request(.searchTweets(query: query, maxId: maxId)) { event in
//                switch event {
//                case .success(let response):
//                    do {
//                        if let json = try response.mapJSON() as? [String: Any], let statuses = json["statuses"] as? [[String : Any]] {
//                            
//                            let tweets = Mapper<Tweet>().mapArray(JSONArray: statuses)
//                            var newMaxId: String? = nil
//                            if let lastTweet = tweets.last {
//                                newMaxId = lastTweet.id
//                            }
//                            
//                            store.dispatch(LoadMoreTweetsAction(results: .success(tweets), maxId: newMaxId))
//                        }
//                    } catch {
//                        store.dispatch(LoadMoreTweetsAction(results: .failure(.somethingWentWrong("Parse Error")), maxId: maxId))
//                    }
//                    
//                    break
//                case .failure(let error): store.dispatch(LoadMoreTweetsAction(results: .failure(.somethingWentWrong(error.localizedDescription)), maxId: maxId))
//                    break
//                }
//        }
        
        return LoadMoreTweets()
    }
}

struct SearchTweets: Action {}
struct LoadMoreTweets: Action {}

struct SearchTweetsAction: Action {
    let query: String
    let results: Result<[Tweet], TwitterAPIError>
    let maxId: String?
}

struct LoadMoreTweetsAction: Action {
    let results: Result<[Tweet], TwitterAPIError>
    let maxId: String?
}

struct ResetSearchAction: Action {}
