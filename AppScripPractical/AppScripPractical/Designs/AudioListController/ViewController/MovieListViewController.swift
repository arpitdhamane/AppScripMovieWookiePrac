//
//  DemoViewController.swift
//  practicalencore
//
//  Created by Mac Mini on 12/11/20.
//  
//

import UIKit

final class MovieListViewController: BaseViewController {
    var viewModel = MovieListViewModel()

    @IBOutlet weak var lblLoading: UILabel!
    @IBOutlet weak var tblMovieList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupUI()
        callInitialAPI()
    }
    
    private func setupUI() {
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Movie List"
        
        tblMovieList.delegate = self
        tblMovieList.dataSource = self
    }
    
    private func callInitialAPI() {
        self.tblMovieList.isHidden = true
        self.lblLoading.text = "Loading movies..."
        viewModel.callMovieListAPI(completion: { (status) in
            DispatchQueue.main.async {
                if status {
                    self.viewModel.fetchMovieList()
                    self.tblMovieList.isHidden = false
                    self.tblMovieList.reloadData()
                } else {
                    self.lblLoading.text = "Some Error occured"
                }
            }
        })
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}

extension MovieListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.viewModel.Movies.count
        return self.viewModel.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
        
        let movie = self.viewModel.movieList[indexPath.row]
        cell.lblMovieName.text = movie.title
        cell.lblMovieRating.text = movie.classification
        var genre = ""
        for item in movie.genres {
            if genre == "" {
                genre = item
            } else {
                genre = genre + ", " + item
            }
        }
        cell.lblMovieCategory.text = genre
        cell.lblMoviePlot.text = movie.overview

        let strURLPoster = movie.poster
        cell.imageMoviePoster.downloaded(from: strURLPoster)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let objDetailVC = storyboard.instantiateViewController(identifier: "DetailViewController") as DetailViewController
        objDetailVC.viewModel.selectedMovie = self.viewModel.movieList[indexPath.row]
        self.present(objDetailVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
