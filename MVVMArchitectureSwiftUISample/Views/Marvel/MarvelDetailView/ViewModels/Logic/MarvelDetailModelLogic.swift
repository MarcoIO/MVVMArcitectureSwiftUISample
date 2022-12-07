//
//  MarvelDetailModelLogic.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 5/12/22.
//


import Foundation
final class MarvelDetailModelLogic {
    static let shared = MarvelListModelLogic()
    struct ViewDataSource: Hashable {
      let title: String
      let imageName: String?
      let sections: [SectionModel]
    }
    struct SectionModel: Hashable {
      let title: String
      let items: [CellModel]
    }
    struct CellModel: Hashable {
      let title: String
    }

    func getMarvelDetailModelDataSource(character: CharactersList) -> ViewDataSource {
        let titleComics = "Comics"
        var itemsComics = [CellModel]()
        if let comics = character.comics, let items = comics.items {
          for item in items {
            if let name = item.name {
              itemsComics.append(CellModel(title: name))
            }
          }
        }
        let sectionComics = SectionModel(title: titleComics, items: itemsComics)

        let titleSeries = "Series"
        var itemsSeries = [CellModel]()
        if let series = character.series, let items = series.items {
          for item in items {
            if let name = item.name {
              itemsSeries.append(CellModel(title: name))
            }
          }
        }
        let sectionSeries = SectionModel(title: titleSeries, items: itemsSeries)

        let titleStories = "Stories"
        var itemsStories = [CellModel]()
        if let stories = character.stories, let items = stories.items {
          for item in items {
            if let name = item.name {
              itemsStories.append(CellModel(title: name))
            }
          }
        }
        let sectionStories = SectionModel(title: titleStories, items: itemsStories)

        let titleEvents = "Events"
        var itemsEvents = [CellModel]()
        if let events = character.events, let items = events.items {
          for item in items {
            if let name = item.name {
              itemsEvents.append(CellModel(title: name))
            }
          }
        }
        let sectionEvents = SectionModel(title: titleEvents, items: itemsEvents)

        var imageName: String?
        if let thumbnail = character.thumbnail, let path = thumbnail.path, let exten = thumbnail.exten {
          imageName = path + "." + exten
        }
        return ViewDataSource(title: character.name ?? "", imageName: imageName, sections: [sectionComics, sectionSeries, sectionStories, sectionEvents])
    }
}



