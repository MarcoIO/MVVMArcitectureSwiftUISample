//
//  Result.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on July 5, 2021

import Foundation

struct CharactersList : Codable, Hashable, Identifiable {

  let comics : Comic?
  let descriptionField : String?
  let events : Event?
  let id : Int?
  let modified : String?
  let name : String?
  let resourceURI : String?
  let series : Series?
  let stories : Story?
  let thumbnail : Thumbnail?
  let urls : [Url]?
  
  enum CodingKeys: String, CodingKey {
    case comics = "comics"
    case descriptionField = "description"
    case events = "events"
    case id = "id"
    case modified = "modified"
    case name = "name"
    case resourceURI = "resourceURI"
    case series = "series"
    case stories = "stories"
    case thumbnail = "thumbnail"
    case urls = "urls"
  }
    init(name: String, thumbnail: Thumbnail?) {
      self.name = name
      self.comics = nil
      self.descriptionField = nil
      self.events = nil
      self.id = 0
      self.modified = nil
      self.resourceURI = nil
      self.series = nil
      self.stories = nil
      self.thumbnail = thumbnail
      self.urls = nil
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    comics = try values.decode(Comic.self, forKey: .comics)
    descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
    events = try values.decode(Event.self, forKey: .events)
    id = try values.decodeIfPresent(Int.self, forKey: .id)
    modified = try values.decodeIfPresent(String.self, forKey: .modified)
    name = try values.decodeIfPresent(String.self, forKey: .name)
    resourceURI = try values.decodeIfPresent(String.self, forKey: .resourceURI)
    series = try values.decode(Series.self, forKey: .series)
    stories = try values.decode(Story.self, forKey: .stories)
    thumbnail = try values.decode(Thumbnail.self, forKey: .thumbnail)
    urls = try values.decodeIfPresent([Url].self, forKey: .urls)
  }

  static func == (lhs: CharactersList, rhs: CharactersList) -> Bool {
      return lhs.id == rhs.id
  }
}
