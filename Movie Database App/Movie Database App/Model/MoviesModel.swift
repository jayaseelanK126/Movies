//
//  MoviesModel.swift
//  Movie Database App
//
//  Created by Pyramid on 24/12/21.
//

import Foundation


struct MoviesModel : Decodable {
    var Title: String
    var Year: String
    var Rated: String
    var Released: String
    var Runtime: String
    var Genre: String
    var Director: String
    var Writer: String
    var Actors: String
    var Plot: String
    var Language: String
    var Country: String
    var Awards: String
    var Poster: String
    var Ratings: [RatingsModel]
    var Metascore: String
    var imdbRating: String
    var imdbVotes: String
    var imdbID: String
    var TypeOfContent: String
    var Response: String
}

struct RatingsModel : Decodable {
    var Source: String
    var Value: String
}

struct Category
{
    var name:String
}

struct Section {
    let letter : String
    let movies : [MoviesModel]
}
