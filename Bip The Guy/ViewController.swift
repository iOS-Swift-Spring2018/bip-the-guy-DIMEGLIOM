//
//  ViewController.swift
//  Bip The Guy
//
//  Created by Mark on 2/12/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var audioPlayer = AVAudioPlayer()
    @IBOutlet var bipImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    
    func photoLibrary() {
    let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
    imagePicker.allowsEditing = false
    
    self.present(imagePicker, animated: true, completion: nil)
    
    }
    
    func playSound() {
        
        let soundName = "scream"
        
        if let sound = NSDataAsset(name: soundName) {
            
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
                
            } catch {
                
                createAlert(title: "Oops", message: "For some reason the sound cant be played")
                
            }
            
        } else {
            
            print("\(soundName) could not be played.")
            
        }
        
    }
    
    func animateImage() {
        
        let bounds = self.bipImage.bounds
        self.bipImage.bounds = CGRect(x: self.bipImage.bounds.origin.x + 60, y: self.bipImage.bounds.origin.y + 60, width: self.bipImage.bounds.size.width - 60, height: self.bipImage.bounds.size.width - 60)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 8.0, animations: { self.bipImage.bounds = bounds }, completion: nil)
        
        
    }
    
    @IBAction func bopHimInTheFace(_ sender: Any) {
        animateImage()
        playSound()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
    let image = info[UIImagePickerControllerOriginalImage] as! UIImage
    bipImage.image = image
    self.dismiss(animated: true, completion: nil)
        
    }
    
    func takePhoto() {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
            
        } else {
            createAlert(title: "Yo camera is broke", message: "Fix it or use yo library")
        }
        
    }
    
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func pickAnImage(_ sender: Any) {
        
        let sheet = UIAlertController(title: "Add a Profile Picture", message: "Please take a photo or choose one from your camera.", preferredStyle: UIAlertControllerStyle.actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (alert:UIAlertAction) in
            
        }
        
        let photoLibrary = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.default) { (alert: UIAlertAction) in
            self.photoLibrary()
        }
        
        let videoLibrary = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default) { (alert: UIAlertAction) in
            self.takePhoto()
            
        }
        
        sheet.addAction(photoLibrary)
        sheet.addAction(videoLibrary)
        sheet.addAction(cancel)
        self.present(sheet, animated: true, completion: nil)
        
    }
    
    @IBAction func upBy200DidPressed(_ sender: Any) {
        bipImage.frame.origin.y -= 200
        
        UIView.animate(withDuration: 1.0, animations: { self.bipImage.frame.origin.y -= 200 })
        
    }
    
    @IBAction func downBy200DidPressed(_ sender: Any) {
       UIView.animate(withDuration: 1.0, animations: { self.bipImage.frame.origin.y += 200 })
    }
    
    @IBAction func increaseBy60DidPressed(_ sender: Any) {
        let largerRect = CGRect(x: bipImage.bounds.origin.x - 60, y: bipImage.bounds.origin.y - 60, width: bipImage.bounds.width + 60, height: bipImage.bounds.height + 60)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 8.0, animations:
            { self.bipImage.bounds = largerRect } )
        
        
    }


}

