//
//  NYArticle.swift
//  iOSAssignment
//
//  Created by MUhammad Sadiq on 08/05/2023.
//

import Foundation

struct NYArticle : Decodable {
    var status : String?
    var copyright : String?
    var num_results : Int?
    var results : [Article]?
}

struct Article : Decodable {
    var uri : String?
    var url : String?
    var id : Int?
    var asset_id : Int?
    var source : String?
    var published_date : String?
    var updated : String?
    var section : String?
    var subsection : String?
    var nytdsection : String?
    var adx_adx_keywordswords : String?
    var column : String?
    var byline : String?
    var type : String?
    var title : String?
    var abstract : String?
    var des_facet : [String]?
    var org_facet : [String]?
    var per_facet : [String]?
    var geo_facet : [String]?
    var media : [Media]?
    var eta_id : Int?
    
    init() {
        self.title = "title"
        self.abstract = "subtitle"
        self.published_date = "dateTime"
    }
}

struct Media : Decodable {
    var type : String?
    var subtype : String?
    var caption : String?
    var copyright : String?
    var approved_for_syndication : Int?
    var mediaMetadata : [MediaMetadata]?
    
    enum CodingKeys: String, CodingKey {
        
        case type = "type"
        case subtype = "subtype"
        case caption = "caption"
        case copyright = "copyright"
        case approved_for_syndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        subtype = try values.decodeIfPresent(String.self, forKey: .subtype)
        caption = try values.decodeIfPresent(String.self, forKey: .caption)
        copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
        approved_for_syndication = try values.decodeIfPresent(Int.self, forKey: .approved_for_syndication)
        mediaMetadata = try values.decodeIfPresent([MediaMetadata].self, forKey: .mediaMetadata)
    }
}

struct MediaMetadata : Decodable {
    var url : String?
    var format : String?
    var height : Int?
    var width : Int?
}
