//
//  UIImageView+URL.swift
//  TheRussianNews
//
//  Created by Yulya Greshnova on 09.09.2022.
//

import Foundation
import UIKit
import Nuke

extension UIImageView {
    func loadFrom(urlAddress: String) {
        Nuke.loadImage(with: urlAddress, into: self)
    }
}
