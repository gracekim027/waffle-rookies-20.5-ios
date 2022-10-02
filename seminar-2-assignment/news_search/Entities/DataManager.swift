//
//  naver_news.swift
//  news_search
//
//  Created by grace kim  on 2022/09/29.
//

import Foundation

class DataManager {
    static let shared : DataManager = DataManager()
    var searchResult : NewsResults?
    private init(){
        
    }
}

struct NewsResults : Decodable {
    let lastBuildDate : String
    let total, start, display : Int
    let items : [NewsCellData]
}

struct NewsCellData : Decodable{
    let title : String
    let originallink : String
    let itemDescription: String
    let pubDate : Date

    //question: codingKey 를 애초에 같은걸로 하면 되는것 아닌가?
    enum CodingKeys: String, CodingKey{
        case title, originallink, link
                case itemDescription = "description"
                case pubDate
    }
    
    init (from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try values.decode(String.self, forKey: .title)
            .replacingOccurrences(of: "&quot;", with: "\"", options: .regularExpression, range: nil)
            .replacingOccurrences(of: "&apos;", with: "'", options: .regularExpression, range: nil)
            .replacingOccurrences(of: "&amp;", with: "&", options: .regularExpression, range: nil)
            .replacingOccurrences(of: "&lt;", with: "<", options: .regularExpression, range: nil)
            .replacingOccurrences(of: "&gt;", with: ">", options: .regularExpression, range: nil)
        
        
        self.itemDescription = try values.decode(String.self, forKey: .itemDescription)
            .replacingOccurrences(of: "&quot;", with: "\"", options: .regularExpression, range: nil)
            .replacingOccurrences(of: "&apos;", with: "'", options: .regularExpression, range: nil)
            .replacingOccurrences(of: "&amp;", with: "&", options: .regularExpression, range: nil)
            .replacingOccurrences(of: "&lt;", with: "<", options: .regularExpression, range: nil)
            .replacingOccurrences(of: "&gt;", with: ">", options: .regularExpression, range: nil)
            
        self.originallink = try values.decode(String.self, forKey: .originallink)
        let date_string = (try values.decode(String.self, forKey: .pubDate)) 
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        dateFormatter.locale = Locale(identifier: "ko_kr")
        let date_full = dateFormatter.date(from: date_string) ?? Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date_full)
        let finalDate = calendar.date(from:components)
        self.pubDate = finalDate ?? Date()
        
    }
}

extension Date {
    static func parse<K: CodingKey>(_ values: KeyedDecodingContainer<K>, key: K) -> Date?{
        guard let dateString = try? values.decode(String.self, forKey: key),
              let date = from(dateString: dateString) else {
            return nil
        }
        
        return date
    }
    
    static func from(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        dateFormatter.locale = Locale(identifier: "ko_kr")
        
        if let date = dateFormatter.date(from: dateString) {
            return date
        }

        return nil
    }
}

