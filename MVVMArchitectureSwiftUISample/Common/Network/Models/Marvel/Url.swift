//
//  Url.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on July 5, 2021

import Foundation

struct Url : Codable, Hashable {
  
  let type : String?
  let url : String?
  
  enum CodingKeys: String, CodingKey {
    case type = "type"
    case url = "url"
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    type = try values.decodeIfPresent(String.self, forKey: .type)
    url = try values.decodeIfPresent(String.self, forKey: .url)
  }
  
}
