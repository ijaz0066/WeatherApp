//
//  Weather.swift
//  LokiWeather
//
//  Created by ijaz ahmad on 2020-02-16.
//  Copyright © 2020 BodiTrak. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case main
        case description
    }
    
    init(id: Int, main: String, description: String) {
        self.id = id
        self.main = main
        self.description = description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let main = try container.decode(String.self, forKey: .main)
        let description = try container.decode(String.self, forKey: .description)
        self.init(id: id, main: main, description: description)
    }
}
