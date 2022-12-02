//
//  Thumbnail.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on July 5, 2021

import Foundation

struct Thumbnail : Codable, Hashable {
  let exten : String?
  let path : String?
  
  enum CodingKeys: String, CodingKey {
    case exten = "extension"
    case path = "path"
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    exten = try values.decodeIfPresent(String.self, forKey: .exten)
    path = try values.decodeIfPresent(String.self, forKey: .path)
  }

    init(exten: String, path: String) {
        self.exten = exten
        self.path = path
    }
  
}
