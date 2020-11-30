//
//  DemoViewController.swift
//  practicalencore
//
//  Created by Mac Mini on 12/11/20.
//
//

import UIKit
import AVFoundation

final class DetailViewController: BaseViewController {

    @IBOutlet weak var imageMovieBackground: UIImageView!
    @IBOutlet weak var imageMoviePoster: UIImageView!
    
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblMoviePlot: UILabel!
    
    @IBOutlet weak var viewGradient: UIView!

    @IBOutlet weak var btnFavourite: UIButton!
    
    var viewModel = DetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }

    private func setup() {
        setupUI()
    }
    
    private func setupUI() {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: viewGradient.frame.size.width, height: viewGradient.frame.size.height))
        let gradient = CAGradientLayer()

        gradient.frame = view.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]

//        viewGradient.layer.insertSublayer(gradient, at: 0)

        let movie = self.viewModel.selectedMovie
        lblMovieName.text = movie!.title
        lblRating.text = movie!.classification
        var genre = ""
        for item in movie!.genres {
            if genre == "" {
                genre = item
            } else {
                genre = genre + ", " + item
            }
        }
        lblGenre.text = genre
        lblMoviePlot.text = movie!.overview

        let strURLPoster = movie!.poster
        imageMoviePoster.downloaded(from: strURLPoster)
        let strURLbackdrop = movie!.backdrop
        imageMovieBackground.downloaded(from: strURLbackdrop)

    }

}
