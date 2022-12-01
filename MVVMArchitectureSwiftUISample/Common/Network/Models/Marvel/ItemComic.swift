//
//  ItemComic.swift
//  MarvelAPIListSample
//
//  Created by marco.iniguez.ollero on 6/7/21.
//

import Foundation
struct ItemComic : Codable, Hashable {
  
  let name : String?
  let resourceURI : String?
  
  enum CodingKeys: String, CodingKey {
    case name = "name"
    case resourceURI = "resourceURI"
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try values.decodeIfPresent(String.self, forKey: .name)
    resourceURI = try values.decodeIfPresent(String.self, forKey: .resourceURI)
  }
  
}
