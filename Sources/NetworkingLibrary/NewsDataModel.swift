//
//  NewsDataModel.swift
//  NetworkingLibrary
//
//  Created by nino on 11/11/24.
//

import Foundation

final public class NewsModel: Decodable {
    public var source: Source?
    public var author: String?
    public var title: String?
    public var description: String?
    public var url: String?
    public var urlToImage: String?
    public var publishedAt: String?
    public var content: String?
    
    public init(source: Source? = nil, author: String? = nil, title: String? = nil, description: String? = nil, url: String? = nil, urlToImage: String? = nil, publishedAt: String? = nil, content: String? = nil) {
        self.source = source
        self.author = author ?? "not founf"
        self.title = title ?? "not founf"
        self.description = description ?? "not founf"
        self.url = url ?? "not founf"
        self.urlToImage = urlToImage ?? "not founf"
        self.publishedAt = publishedAt ?? "not founf"
        self.content = content ?? "not founf"
    }
}

final public class Source: Decodable {
    public var id: String?
    public var name: String?
}

public struct NewsResponseData: Decodable {
    public var status: String?
    public var totalResults: Int?
    public var articles: [NewsModel]?
}


