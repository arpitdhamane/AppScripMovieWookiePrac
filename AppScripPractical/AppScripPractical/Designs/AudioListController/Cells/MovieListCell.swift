//
//  MovieListCell.swift
//  AppScripPractical
//
//  Created by Mac Mini on 12/11/20.
//

import UIKit

class MovieListCell: UITableViewCell {

    @IBOutlet weak var imageMovieBackground: UIImageView!
    @IBOutlet weak var imageMoviePoster: UIImageView!
    
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblDirectorName: UILabel!
    @IBOutlet weak var lblMovieCategory: UILabel!
    @IBOutlet weak var lblMoviePlot: UILabel!
    @IBOutlet weak var lblMovieRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
