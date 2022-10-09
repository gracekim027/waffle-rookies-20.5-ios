//
//  ImageLoader.swift
//  movies
//
//  Created by grace kim  on 2022/10/09.
//

import Foundation
import UIKit

private let _imageCache = NSCache<AnyObject, AnyObject>()

/*
class ImageLoader: ObservableObject {
    //@Published var image: UIImage?
    //var image: UIImage?
    //@Published var isLoading = false
    var isLoading = false
    
    var imageCache = _imageCache
    
    func loadImage(with url: URL) -> UIImage{
        let image : UIImage
        let urlString = url.absoluteString
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            image = imageFromCache
            print("error in getting image")
            return UIImage()
        }
        
        do {
            let data  = try Data(contentsOf: url)
            guard let image2 = UIImage(data: data) else {
            print("error in getting image")
            }
            image = image2
        } catch {
            print(error.localizedDescription)
        }
        
        
        
        /*
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else {return}
            do {
                let data  = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                 return
                }
                self.imageCache.setObject(image, forKey: urlString as AnyObject)
                DispatchQueue.main.async {
                    self.image = image
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return image ?? UIImage()
    }*/
}
}
 */
