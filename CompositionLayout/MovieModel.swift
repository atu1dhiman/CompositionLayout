//
//  MovieModel.swift
//  CompositionLayout
//
//  Created by Atul Dhiman on 05/09/22.
//

import Foundation

struct MovieModel: Codable
{
    var resultCount: Int?
    var results:[ResultModel]?
}

struct ResultModel: Codable
{
    var artistName: String?
    var kind: String?
    var artworkUrl100: String?
    let trackName: String?
}



