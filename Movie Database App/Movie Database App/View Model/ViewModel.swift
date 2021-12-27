//
//  ViewModel.swift
//  Movie Database App
//
//  Created by Pyramid on 26/12/21.
//

import Foundation

struct ViewModel
{
    func loadJson(filename fileName: String) -> [MoviesModel]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([MoviesModel].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}


struct Section {
    let letter : String
    let movies : [MoviesModel]
}
