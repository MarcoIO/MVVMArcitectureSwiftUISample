//
//  Datum.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on July 5, 2021

import Foundation

struct Datum : Codable, Hashable {
  
  let count : Int?
  let limit : Int?
  let offset : Int?
  let results : [CharactersList]?
  let total : Int?
  
  enum CodingKeys: String, CodingKey {
    case count = "count"
    case limit = "limit"
    case offset = "offset"
    case results = "results"
    case total = "total"
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    count = try values.decodeIfPresent(Int.self, forKey: .count)
    limit = try values.decodeIfPresent(Int.self, forKey: .limit)
    offset = try values.decodeIfPresent(Int.self, forKey: .offset)
    results = try values.decodeIfPresent([CharactersList].self, forKey: .results)
    total = try values.decodeIfPresent(Int.self, forKey: .total)
  }
  
}
