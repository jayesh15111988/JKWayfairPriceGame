//
//  DownloadFileSpec.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli on 10/12/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import JKWayfairPriceGame

class DownloadFileSpec: QuickSpec {
    
    override func spec() {
        describe("Sample testing") { 
            it("This test should correctly mock the desired function call", closure: { 
                let downloader = DownloadFileClass(downloadProtocol: DummyFileDownloader())
                expect(downloader.downloadedFile).to(equal("dummy data"))
            })
        }
    }
    
    class DummyFileDownloader: DownloadFileProtocol {
        func downloadFile(with name: String, completion: (String) -> ()) {
            print("Downloading dummy file")
            completion("dummy data")
            
        }
    }
}
