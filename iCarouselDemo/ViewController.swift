//
//  ViewController.swift
//  iCarouselDemo
//
//  Created by Guang Lei on 2019/7/2.
//  Copyright © 2019 leiguang. All rights reserved.
//

import UIKit
import iCarousel

class ViewController: UIViewController {

    @IBOutlet weak var carousel: iCarousel!
    
    let items: [String] = (0...10).map { "\($0)" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carousel.dataSource = self
        carousel.delegate = self
        carousel.bounces = false;
        carousel.isPagingEnabled = true
        carousel.type = .custom;
    }
}

extension ViewController: iCarouselDataSource {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return items.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        if let view = view as? UILabel {
            label = view
        } else {
            let width = UIScreen.main.bounds.width - 80 * 2
            let height = UIScreen.main.bounds.width
            label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
            label.backgroundColor = .cyan
            label.textAlignment = .center
        }
        label.text = items[index]
        return label
    }
}

extension ViewController: iCarouselDelegate {
    
    func carousel(_ carousel: iCarousel, itemTransformForOffset offset: CGFloat, baseTransform transform: CATransform3D) -> CATransform3D {
        let maxScale: CGFloat = 1.0
        let minScale: CGFloat = 0.8
        var tempTransform: CATransform3D
        if offset <= 1 && offset >= -1 {
            let tempScale = offset < 0 ? 1 + offset : 1 - offset
            let slope = (maxScale - minScale) / 1
            let scale = minScale + slope * tempScale
            tempTransform = CATransform3DScale(transform, scale, scale, 1)
        } else {
            tempTransform = CATransform3DScale(transform, minScale, minScale, 1)
        }
        return CATransform3DTranslate(tempTransform, offset * carousel.itemWidth * 1.35, 0.0, 0.0)
    }
}
