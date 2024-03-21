//
//  detailsVC.swift
//  sanatKitabi
//
//  Created by Süleyman Kabayel on 18.03.2024.
//

import UIKit
import CoreData

class detailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    

    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var artistText: UITextField!
    
    @IBOutlet weak var yearText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeybord))
        view.addGestureRecognizer(gestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let imageTapRecongnizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecongnizer)
    }
    
    @objc func selectImage()
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func hideKeybord()
    {
        view.endEditing(true)
    }
    

  
    @IBAction func buttonTapped(_ sender: Any) {
        
        print("tiklama")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let context = appDelegate.persistentContainer.viewContext

        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)

        
        
        //Atributes
        newPainting.setValue(nameText.text, forKey: "name")

        newPainting.setValue(artistText.text, forKey: "artist")

        if let year = Int(yearText.text!)
        {
            newPainting.setValue(year, forKey: "year")
        }

        
        newPainting.setValue(UUID(), forKey: "id")

        
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        
        newPainting.setValue(data, forKey: "image")

        
        do{
            try context.save()
            print("saved")
           
        }catch{
           print("faild")
        }
    }
    
    
    

}
