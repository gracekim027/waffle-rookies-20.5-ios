//
//  LoadNewsAPI.swift
//  news_search
//
//  Created by grace kim  on 2022/09/29.
//

import Foundation
import UIKit

class LoadNewsAPI{
    
    var start = 1
    var display = 20
    var sort = "sim"

    
    static var shared = LoadNewsAPI()
    let jsconDecoder : JSONDecoder = JSONDecoder()
    
    func urlTaskDone(){
        if ((DataManager.shared.searchResult?.items.isEmpty) == nil){
        }else{
            let newsItem = DataManager.shared.searchResult?.items[0]
            print(newsItem ?? " url not requested correctly")
        }
    }
    
    typealias CompletionHandler = (_ success:Bool)->Void
    
    func requestAPI(queryValue : String, completionHandler: @escaping (Bool) -> Void){
        let clientID : String = "Sdb4fwrKFyJD8fnfgfU7"
        let clientSecret : String = "s1CtADbVo8"
        let query: String  = "https://openapi.naver.com/v1/search/news.json?query=\(queryValue)&display=\(display)&start=\(start)&sort=\(sort)"
                let encodedQuery: String = query.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
                let queryURL: URL = URL(string: encodedQuery)!
        
        var requestURL = URLRequest(url: queryURL)
                requestURL.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
                requestURL.addValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
                    guard error == nil else { return }
                    guard let data = data else { return }
                    
                    do {
                        //let searchInfo: NewsResults = try self.jsconDecoder.decode(NewsResults.self, from: data)
                        let searchInfo : NewsResults = try self.jsconDecoder.decode(NewsResults.self, from: data)
                        DataManager.shared.searchResult = searchInfo
                        
                        if (((DataManager.shared.searchResult?.items.isEmpty)) != nil){
                            //검색결과가 없을때
                            let flag = true
                            completionHandler(flag)
                            print("no results, return empty table")
                        }else{
                            let newsItem = DataManager.shared.searchResult?.items[0]
                            let flag = true
                            completionHandler(flag)
                            print(newsItem ?? " url not requested correctly")
                        }
                    } catch {
                        print("error!")
                    }
                }
                task.resume()
        
    }
}
