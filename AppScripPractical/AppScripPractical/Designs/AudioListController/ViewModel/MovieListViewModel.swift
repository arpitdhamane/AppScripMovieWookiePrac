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
    var movieModel: [Movie] = []
    var elementName: String = String()
    
    var aTitle = String()
    var aArtist = String()
    var aName = String()
    var aLink = String()
    var aCategory = String()
    var aImage = String()
    
    var coreDataUtill = CoreDataFunctions()
    
    func fetchMovieList() {
        Movies = coreDataUtill.fetchMovieList()
    }
    
//    func saveMovieToDataBase(completion: @escaping (Bool) -> ()) {
//        for index in 0..<self.MovieModel.count {
//            let item  = self.MovieModel[index]
//            DispatchQueue.main.async {
//                self.coreDataUtill.save(title: item.title, name: item.name, link: item.link, artist: item.artist, category: item.category, image: item.image)
//            }
//            if index == 19 {
//                completion(true)
//            }
//        }
//    }
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
            if let data = data {
                self.loans = self.parseJsonData(data: data)

                // Reload table view
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
            }

//            do {
//                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
//                    if let allContent = json["movies"] as? [[String: Any]] {
//                        for item in allContent {
//                            if let movie = Movies(json: item) {
//                                self.movieModel.append(movie)
//                            }
////                            print("--------------------------------")
//                        }
//                    }
//                }
//            } catch {
//                print("Error: Couldn't parse JSON. \(error.localizedDescription)")
//            }
//
            print(self.movieModel.count)
        }
        
        task.resume()
    }
    
    func parseJsonData(data: Data) -> [Loan] {

        var movies = [Movie]()

        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary

            // Parse JSON data
            let jsonLoans = jsonResult?["loans"] as! [AnyObject]
            for jsonLoan in jsonLoans {
                let loan = Movie()
                loan.name = jsonLoan["name"] as! String
                loan.amount = jsonLoan["loan_amount"] as! Int
                loan.use = jsonLoan["use"] as! String
                let location = jsonLoan["location"] as! [String:AnyObject]
                loan.country = location["country"] as! String
                loans.append(loan)
            }
        } catch {
            print(error)
        }

        return loans
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
