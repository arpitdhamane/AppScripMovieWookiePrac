//
//  DemoViewModel.swift
//  practicalencore
//
//  Created by Mac Mini on 12/11/20.
//  
//

import Foundation
import CoreData

class MovieListViewModel: BaseViewModel {
    var movieList: [Movie] = []
    var elementName: String = String()
    
    var aTitle = String()
    var aArtist = String()
    var aName = String()
    var aLink = String()
    var aCategory = String()
    var aImage = String()
    
    var coreDataUtill = CoreDataFunctions()
    
    func fetchMovieList() {
//        Movies = coreDataUtill.fetchMovieList()
    }
    
    func callMovieListAPI(completion: @escaping (Bool) -> ()) {
        
        var request = URLRequest(url: URL(string: "https://wookie.codesubmit.io/movies")!,timeoutInterval: Double.infinity)
        request.addValue("Bearer Wookie2019", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                completion(false)
                return
            }
            
            // Parse JSON data
            self.movieList = self.parseJsonData(data: data)
            
            print(self.movieList.count)
            completion(true)
        }
        
        task.resume()
    }
    
    func parseJsonData(data: Data) -> [Movie] {

        var movies = [Movie]()

        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary

            // Parse JSON data
            let jsonMovies = jsonResult?["movies"] as! [AnyObject]
            for jsonMovie in jsonMovies {
                var movie = Movie()
                movie.backdrop = jsonMovie["backdrop"] as! String
                movie.genres = jsonMovie["genres"] as![String]
                movie.classification = jsonMovie["classification"] as! String
                movie.id = jsonMovie["id"] as! String
                movie.length = jsonMovie["length"] as! String
                movie.overview = jsonMovie["overview"] as! String
                movie.poster = jsonMovie["poster"] as! String
                movie.slug = jsonMovie["slug"] as! String
                movie.title = jsonMovie["title"] as! String
                movies.append(movie)
            }
        } catch {
            print(error)
        }

        return movies
    }
}

extension MovieListViewModel: XMLParserDelegate {
    
    // Did Start Element Method
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        if elementName == "entry" {
            aTitle = String()
            aName = String()
            aArtist = String()
            aLink = String()
            aCategory = String()
            aImage = String()
        }
        if elementName == "link" {
            if let href = attributeDict["href"] {
                if href.contains("plus.aac.p.m4a") {
                    aLink = href
                }
            }
        }
        if elementName == "category" {
            if let term = attributeDict["term"] {
                aCategory = term
            }
        }

        self.elementName = elementName
    }

    // Found characters Method
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if (!data.isEmpty) {
            if self.elementName == "title" {
                aTitle += data
            } else if self.elementName == "im:name" {
                aName += data
            } else if self.elementName == "im:artist" {
                aArtist += data
            } else if self.elementName == "link" {
//                aLink += data
            } else if self.elementName == "category" {
//                aCategory += data
            } else if self.elementName == "im:image" {
                if string.contains("170x170bb") {
                    aImage += data
                }
            }
        }
    }

    // Did End Element Method
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "entry" {
//            let Movie = Welcome(title: aTitle, name: aName, link: aLink, artist: aArtist, category: aCategory, image: aImage)
//            MovieModel.append(Movie)
        }
    }

}
