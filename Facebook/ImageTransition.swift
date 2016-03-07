//
//  ImageTransition.swift
//  Facebookk
//
//  Created by Dorahan Arapgirlioglu on 3/6/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class ImageTransition: BaseTransition {
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        //Cast the VCS
        let newsFeedViewController = fromViewController as! NewsFeedViewController
        let photoViewController = toViewController as! PhotoViewController
        
        // create window
        let window = UIApplication.sharedApplication().keyWindow
        
        /*
        // create background view and setup
        let tempBackgroundView = UIView()
        tempBackgroundView.backgroundColor = UIColor(white: 0, alpha: 0)
        tempBackgroundView.frame = toViewController.view.frame
        */
        
        
        //Add clone image
        let movingImageView = UIImageView()
        movingImageView.frame = newsFeedViewController.imageView.frame
        movingImageView.image = newsFeedViewController.imageView.image
        movingImageView.clipsToBounds = newsFeedViewController.imageView.clipsToBounds
        movingImageView.contentMode = newsFeedViewController.imageView.contentMode
        
        //Convert the frames to match positions
        movingImageView.frame = window!.convertRect(newsFeedViewController.imageView.frame, fromView: newsFeedViewController.scrollView)
        
        //movingImageView.frame.origin.y -= newsFeedViewController.scrollView.contentOffset.y
        
        containerView.addSubview(movingImageView)
        
        
        //Initially hide
        newsFeedViewController.imageView.alpha = 0
        photoViewController.imageView.alpha = 0
        toViewController.view.alpha = 0
        
        
        //animations
        UIView.animateWithDuration(duration, animations: {

            toViewController.view.alpha = 1
            
            movingImageView.frame = photoViewController.imageView.frame
            movingImageView.contentMode = photoViewController.imageView.contentMode
            
            
            }) { (finished: Bool) -> Void in
                newsFeedViewController.imageView.alpha = 1
                photoViewController.imageView.alpha = 1
                movingImageView.removeFromSuperview()
                self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        //Cast the VCS
        let newsFeedViewController = toViewController as! NewsFeedViewController
        let photoViewController = fromViewController as! PhotoViewController
        
        
        // create window
        let window = UIApplication.sharedApplication().keyWindow
        
        //Clone the selected image
        let movingImageView = UIImageView()
        movingImageView.frame = photoViewController.imageView.frame
        movingImageView.image = photoViewController.imageView.image
        movingImageView.clipsToBounds = photoViewController.imageView.clipsToBounds
        movingImageView.contentMode = photoViewController.imageView.contentMode
        
        movingImageView.frame = window!.convertRect(photoViewController.imageView.frame, fromView: photoViewController.scrollView)
        
        
        //Create a variable to identify the destination for the cloned image
        var destinationImageFrame = newsFeedViewController.imageView.frame
        destinationImageFrame.origin.y -= newsFeedViewController.scrollView.contentOffset.y
        
        //Origin of the cloned image
        //movingImageView.frame.origin.y -= photoViewController.scrollView.contentOffset.y
        
        
        fromViewController.view.alpha = 1
        UIView.animateWithDuration(duration, animations: {
            
            fromViewController.view.alpha = 0
            movingImageView.frame = destinationImageFrame
            movingImageView.contentMode = newsFeedViewController.imageView.contentMode
            
            movingImageView.frame = window!.convertRect(newsFeedViewController.imageView.frame, fromView: newsFeedViewController.scrollView)
            
            }) { (finished: Bool) -> Void in
                
                newsFeedViewController.imageView.alpha = 1
                movingImageView.removeFromSuperview()
                
                self.finish()
        }
    }
    

}
