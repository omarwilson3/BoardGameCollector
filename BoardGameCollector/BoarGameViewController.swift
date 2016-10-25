//
//  BoarGameViewController.swift
//  BoardGameCollector
//
//  Created by Omar Wilson on 10/21/16.
//  Copyright © 2016 Omar Wilson. All rights reserved.
//

import UIKit

class BoarGameViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var boardGameImageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    var boardGame : BoardGame? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if boardGame != nil {
            boardGameImageView.image = UIImage(data: boardGame!.image as! Data)
            titleTextField.text = boardGame!.title
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
    }


    @IBAction func photosTapped(_ sender: AnyObject) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        boardGameImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: AnyObject) {
    }
    
    @IBAction func addTapped(_ sender: AnyObject) {
         if boardGame != nil {
            boardGame!.title = titleTextField.text
            boardGame!.image = UIImagePNGRepresentation(boardGameImageView.image!) as NSData?
         } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let boardGame = BoardGame(context: context)
            boardGame.title = titleTextField.text
            boardGame.image = UIImagePNGRepresentation(boardGameImageView.image!) as NSData?
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: AnyObject) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(boardGame!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
}
