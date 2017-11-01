//
//  PhotoCell.swift
//  CameraApp1
//
//  Created by Rajita Pujare on 8/3/17.
//  Copyright © 2017 Rajita Pujare. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    var pathname = String()
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    
    
    @IBOutlet weak var ph: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.ph.image = nil
        
    }
    
}
