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
    

    @IBAction func saveButton(_ sender: Any) {
        
        print("tiklama")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        print("eror1")
        let context = appDelegate.persistentContainer.viewContext
        print("eror2")
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        print("eror3")
        
        
        //Atributes
        newPainting.setValue(nameText.text, forKey: "name")
        print("isim")
        newPainting.setValue(artistText.text, forKey: "artist")
        print("resam")
        if let year = Int(yearText.text!)
        {
            newPainting.setValue(year, forKey: "year")
        }
        print("yil")
        
        newPainting.setValue(UUID(), forKey: "id")
        print("id")
        
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        
        newPainting.setValue(data, forKey: "image")
        print("resim")
        
        do{
            try context.save()
            print("sucses")
        }catch{
            print("eror")
        }
    }
    
    

}
