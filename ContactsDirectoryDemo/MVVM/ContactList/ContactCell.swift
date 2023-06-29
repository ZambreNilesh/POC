//
//  NZPhotoCell.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 24/12/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

import UIKit
import Downloader

class ContactCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var title: UILabel!
    private var cancelDownload: CancelDowloading?
    private var photoDownloader: PhotoDownloader?
    private var pesonModel: PersonModel?
    private var iNZownloading: Bool = true
    private let activityIndicator: UIActivityIndicatorView =  UIActivityIndicatorView(style: .medium)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        //You Code here
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLoader()
    }
    
    private func setupLoader() {
        addSubview(activityIndicator)
        activityIndicator.center = self.center
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stopDownloading()
        avatar.image = nil
        photoDownloader = nil
    }
    
    
    func setPerson(person: PersonModel){
        self.pesonModel = person
        title.text = "\(person.firstName ?? "") \(person.lastName ?? "")"
        
        photoDownloader = PhotoDownloader(maxCacheTimeInHour: 1, URLCache: CacheHandler.sharedHandler.cache)
        startDownloading()
    }
    
    private func startDownloading() {
        activityIndicator.startAnimating()
        guard let person = pesonModel, let avatar = person.avatar else { return }
        cancelDownload = photoDownloader?.loadImage(with: avatar, completion: {[weak self] downloadResult in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            switch downloadResult {
            case let .success(image):
                self.avatar.image = image
            case .noData, .error, .userCancelled:
                self.avatar.image =  UIImage(named: "error")
            }
        })
    }
    
    private func stopDownloading() {
        cancelDownload?()
    }
    
    @IBAction func pauseResumeAction(_ sender: Any) {
        iNZownloading ? stopDownloading() : startDownloading()
        let buttonImage = iNZownloading
            ? UIImage(systemName: "square.and.arrow.down.fill")
            : UIImage(named: "close")
        iNZownloading = !iNZownloading
    }
}
