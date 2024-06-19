//
//  TextData.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 10.06.2024.
//

import Foundation

enum TextData: String {
    case titleCharacters = "Characters"
    case titleLocations = "Locations"
    case titleEpisodes = "Episodes"
    
    case searchCharacter = "Search the Сharacter"
    case searchLocation = "Search the Location"
    case searchEpisode = "Search the Episode"
    
    case noData = "No Residents"
    
    case shareCharacter = "Check out this character from Rick and Morty:\n\nName:"
    case shareLocation = "Check out this location from Rick and Morty:\n\nName:"
    case shareHaveResidents = "\n\nResidents:\n"
    case shareNoResidents = "\n\nThis location has no known residents."
    case shareEpisode = "Check out this episode from Rick and Morty:\n\nName:"
    case shareHaveCharacters = "\n\nCharacters:\n"
}
