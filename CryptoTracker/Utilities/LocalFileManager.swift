//
//  LocalFileManager.swift
//  CryptoTracker
//
//  Created by Arkar Min on 24/09/2024.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    private init(){}
    
    func saveImage(image : UIImage, imageName : String, folderName : String){
        
        
        //create folder if not exist yet
        createFolderIfNeeded(folderName: folderName)
        
        //get image data and url
        guard
            let data  = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
        else {
            return
        }
        
        // save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image. \(imageName) : \(error)")
        }
    }
    
    func getImage (imageName : String, folderName : String ) -> UIImage? {
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path)
        else {  return  nil }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    func createFolderIfNeeded(folderName : String){
        guard let url = getURLForFolder(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path){
            do{
                try FileManager.default.createDirectory(atPath: url.path, withIntermediateDirectories: true, attributes: nil)
            }catch let error {
                print ("Error in creating folder. \(folderName) \(error)")
            }
        }
        
    }
    
    func getURLForFolder(folderName : String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return url.appending(path: folderName)
    }
    
    func getURLForImage(imageName : String, folderName : String) -> URL? {
        guard let url = getURLForFolder(folderName: folderName) else { return nil}
        
        return url.appending(path: imageName + ".png")
    }
    
}
