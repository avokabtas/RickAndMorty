//
//  TextData.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 10.06.2024.
//

import Foundation

enum TextData: String {
    /// Заголовки в Navigation
    case titleCharacters = "Characters"
    case titleLocations = "Locations"
    case titleEpisodes = "Episodes"
    
    /// В поисковой строке
    case searchCharacter = "Search the Сharacter"
    case searchLocation = "Search the Location"
    case searchEpisode = "Search the Episode"
    
    /// В таблице, когда нет персонажей
    case noData = "No Residents"
    
    /// Поделиться карточкой
    case shareCharacter = "Check out this character from Rick and Morty:\n\nName:"
    case shareLocation = "Check out this location from Rick and Morty:\n\nName:"
    case shareHaveResidents = "\n\nResidents:\n"
    case shareNoResidents = "\n\nThis location has no known residents."
    case shareEpisode = "Check out this episode from Rick and Morty:\n\nName:"
    case shareHaveCharacters = "\n\nCharacters:\n"
}
