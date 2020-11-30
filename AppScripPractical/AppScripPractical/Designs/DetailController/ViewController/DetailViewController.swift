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
    @IBOutlet weak var lblDirectorName: UILabel!
    @IBOutlet weak var lblMoviePlot: UILabel!

    @IBOutlet weak var btnFavourite: UIButton!
    
    var viewModel = DetailViewModel()
    var player: AVPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }

    private func setup() {
        setupUI()
    }
    
    private func setupUI() {
        let strImageURL = self.viewModel.selectedMovie!.value(forKeyPath: "image") as? String ?? ""
//        self.imageMovie.downloaded(from: strImageURL)
        let strMovieURL = self.viewModel.selectedMovie!.value(forKeyPath: "link") as? String ?? ""

//        self.btnPlayPauseOutlet.setTitle("Pause", for: .normal)
    }

}
