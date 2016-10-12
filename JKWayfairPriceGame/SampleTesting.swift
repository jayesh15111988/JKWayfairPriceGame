//
//  SampleTesting.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli on 10/12/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation

protocol DownloadFileProtocol {
    func downloadFile(with name: String, completion: (String) -> ())
}

class DownloadFileClass {
    
    var downloadedFile: String = ""
    
    init(downloadProtocol: DownloadFileProtocol) {
        downloadProtocol.downloadFile(with: "something", completion: {value in
            print("Value \(value)")
            self.downloadedFile = value
        })
    }
}

class DummyDownloader: DownloadFileProtocol {
    func downloadFile(with name: String, completion: (String) -> ()) {
        print("Downloading File")
        completion("Downloaded file")
    }
}
