//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Виталий Татун on 22.02.22.
//

import UIKit

@MainActor
class ViewController: UIViewController {
    
    let photoInfoController = PhotoInfoController()
    
    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var copyrightLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var progressBar: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = ""
        imageView.image = UIImage(systemName: "photo.on.rectangle")
        descriptionLabel.text = ""
        copyrightLabel.text = ""
        indicator.startAnimating()
        progressBar.setProgress(0.5, animated: true)
        
        Task {
            do {
                let photoInfo = try await photoInfoController.fetchingPhotoInfo()
                updateUI(with: photoInfo)
                indicator.stopAnimating()
                indicator.hidesWhenStopped = true
                

                
            } catch {
                updateUI(error)
            }
        }
    }
    
    func updateUI(_ error: Error) {
        self.title = "Error fethcing photo"
        self.imageView.image = UIImage(systemName: "exclamationmark.octagon")
        self.descriptionLabel.text = error.localizedDescription
        self.copyrightLabel.text = ""
    }
    
    func updateUI(with photoInfo: PhotoInfo ) {
        Task {
            do {
                let image = try await photoInfoController.fetchImage(from: photoInfo.url)
                title = photoInfo.title
                imageView.image = image
                descriptionLabel.text = photoInfo.description
                copyrightLabel.text = photoInfo.copyright
            } catch {
                updateUI(error)
            }
        }
    }
    
}

