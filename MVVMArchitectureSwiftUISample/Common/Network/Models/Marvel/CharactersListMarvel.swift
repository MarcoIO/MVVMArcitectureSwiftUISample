//
//  CharactersList.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on July 5, 2021

import Foundation

struct CharactersListMarvel : Codable, Hashable {
  
  let attributionHTML : String?
  let attributionText : String?
  let code : Int?
  let copyright : String?
  let data : Datum?
  let etag : String?
  let status : String?
  
  enum CodingKeys: String, CodingKey {
    case attributionHTML = "attributionHTML"
    case attributionText = "attributionText"
    case code = "code"
    case copyright = "copyright"
    case data = "data"
    case etag = "etag"
    case status = "status"
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    attributionHTML = try values.decodeIfPresent(String.self, forKey: .attributionHTML)
    attributionText = try values.decodeIfPresent(String.self, forKey: .attributionText)
    code = try values.decodeIfPresent(Int.self, forKey: .code)
    copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
    data = try values.decode(Datum.self, forKey: .data)
    etag = try values.decodeIfPresent(String.self, forKey: .etag)
    status = try values.decodeIfPresent(String.self, forKey: .status)
  }
  
}
