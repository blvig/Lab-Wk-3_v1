//
//  CanvasViewController.swift
//  Lab Wk 3_v1
//
//  Created by Vig, Bonnie on 10/26/16.
//  Copyright © 2016 Vig, Bonnie. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    @IBOutlet weak var deadImage: UIImageView!
    @IBOutlet weak var excitedImage: UIImageView!
    
    var trayOriginalCenter: CGPoint!
    var velocity = sender.velocity(in: view)
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let didPanTray = UIPanGestureRecognizer(target: self, action: #selector(didPanTray(sender:)))
        
        trayDownOffset = 160
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x, y: trayView.center.y + trayDownOffset)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
    
        
        if sender.state == UIGestureRecognizerState.began { print ("gesture has begun")
            trayOriginalCenter = trayView.center
        } else if sender.state == UIGestureRecognizerState.changed { print ("gesture has changed")
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if sender.state == UIGestureRecognizerState.ended { print ("gesture has ended")
            if velocity.y > 0 {UIView.animate(withDuration: 0.3) {self.trayView.center = self.trayDown }
            } else {
                UIView.animate(withDuration: 0.3) {self.trayView.center = self.trayUp
            }
        }
    }

    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == UIGestureRecognizerState.began {print ("create new face")
            var imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center.y += trayView.frame.origin.y
        } else if sender.state == UIGestureRecognizerState.changed {print ("gesture has changed")
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x = translation.x, y: newlyCreatedFaceOriginalCenter.y = translation.y)
        } else if sender.state == UIGestureRecognizerState.ended {print ("gesture has ended")
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
