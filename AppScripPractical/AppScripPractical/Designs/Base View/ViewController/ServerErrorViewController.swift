//
//  ServerErrorViewController.swift
//  AppScripPractical
//
//  Created by Mac Mini on 30/11/20.
//  
//

import UIKit

final class ServerErrorViewController: BaseViewController {

    var tryAgainClouser:(() -> Void)?
    
    @IBOutlet weak var btnTryAgain: UIButton!
    
    override var description: String {
        return "No-Internet Screen"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnTryAgain.addTarget(self, action: #selector(self.btnTryAgainClick), for: .touchUpInside)
    }
    
    @objc func btnTryAgainClick() {
    }

}
