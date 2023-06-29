//
//  DownloaderContarct.swift
//  Downloader
//
//  Created by Nilesh Zambre on 23/12/21.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

public typealias DownloadCompletion =  (PhotoDownloadResult) -> ()
public typealias CancelDowloading = () -> Void
protocol DownloaderContract {
    func loadImage(with url: String, completion :@escaping (DownloadCompletion)) -> CancelDowloading
    func cancelSession()
}
