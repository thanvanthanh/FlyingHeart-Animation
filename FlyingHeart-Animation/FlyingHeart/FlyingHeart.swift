//
//  FlyingHeart.swift
//  FlyingHeart-Animation
//
//  Created by Thân Văn Thanh on 12/11/2022.
//

import UIKit

extension UIViewController {
    
    func addHeartAnimation() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:))))
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        (0...10).forEach { (_) in
            let translation = recognizer.location(in: view)
            createAnimation(translation: translation, duration: 2)
        }
    }
    
    private func createAnimation(translation: CGPoint, duration: CFTimeInterval) {
        
        let duration = duration + Double.random(in: 0...1) * 1
        
        // Create Image
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        imageView.tintColor = UIColor(red: .random(in: 0...1),
                                      green: .random(in: 0...1),
                                      blue: .random(in: 0...1), alpha: .random(in: 0...1))
        
        let dimension = 10 + Double.random(in: 0...1) * 50
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath(position: translation).cgPath
        animation.duration = duration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        imageView.layer.add(animation, forKey: nil)
        view.addSubview(imageView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            imageView.removeFromSuperview()
        }
    }
    
    
    private func customPath(position: CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: position.x, y: position.y))
        
        let endPoint = CGPoint(x: position.x, y: 0)
        
        let randomXShift = 100 + Double.random(in: 0...1) * 400
        let randomYShift = (100 + Double.random(in: 0...1) * 100)
        
        let cp1 = CGPoint(x: position.x + CGFloat(randomXShift), y: position.y - CGFloat(randomYShift))
        let cp2 = CGPoint(x: position.x - CGFloat(randomXShift), y: position.y - CGFloat(randomYShift + 100))
        
        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
        return path
    }
}
