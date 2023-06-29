//
//  ContactDetailsViewController.swift
//  ContactsDirectoryDemo
//
//  Created by Zambre Nilesh Appasaheb on 29/06/23.
//

import UIKit
import CommonCode
import Downloader

class ContactDetailsViewController: BaseViewController {
    private var iNZownloading: Bool = true
    private let activityIndicator: UIActivityIndicatorView =  UIActivityIndicatorView(style: .medium)
    private var cancelDownload: CancelDowloading?
    private var photoDownloader: PhotoDownloader?
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var facColor: UILabel!
    var person: PersonModel?
    override class var storyboardName: String{ "ContactDetailsViewController"}
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = "\(person?.firstName ?? "") \(person?.lastName ?? "")"
        jobTitle.text = "\(person?.jobtitle ?? "")"
        email.text = "\(person?.email ?? "")"
        facColor.text = "\(person?.favouriteColor ?? "")"
        startDownloading()
    }
    func setPerson(person: PersonModel){
        self.person = person
       
    }
    
    private func setupLoader() {
        self.view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopDownloading()
        avatar.image = nil
        photoDownloader = nil
    }
    
    private func startDownloading() {
        activityIndicator.startAnimating()
        guard let person = person, let avatar = person.avatar else { return }
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
}
