//
//  ViewController.swift
//  CarСatalog
//
//  Created by Yaroslav Surovtsev on 11.07.17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import UIKit

class AddNewCarViewController: UIViewController {

    @IBOutlet private(set) weak var brandTextField: UITextField!
    @IBOutlet private(set) weak var modelTextField: UITextField!
    @IBOutlet private(set) weak var releaseDateTextField: UITextField! {
        didSet {
            releaseDateTextField.inputView = datePicker
            releaseDateTextField.addTarget(self,
                                           action: #selector(self.releaseDateEditingDidBegin),
                                           for: UIControlEvents.editingDidBegin)
        }
    }
    
    weak var delegate: AddNewCarDelegate?
    weak var carForEdit: Car?
    
    private(set) lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self,
                             action: #selector(self.datePickerChanged),
                             for: .valueChanged)
        return datePicker
    }()
    
    private(set) lazy var dateFormat: DateFormatter = {
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .medium
        return dateFormat
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCarForEdit()
    }
    
    private func loadCarForEdit() {
        if let carForEdit = carForEdit {
            brandTextField.text = carForEdit.brand
            modelTextField.text = carForEdit.model
            releaseDateTextField.text = dateFormat.string(from: carForEdit.releaseDate)
        }
    }
    
    func releaseDateEditingDidBegin(sender: UITextField) {
        if sender.text!.isEmpty {
            releaseDateTextField.text = dateFormat.string(from: datePicker.date)
        }
    }
    
    func datePickerChanged(sender: UIDatePicker) {
        releaseDateTextField.text = dateFormat.string(from: sender.date)
    }

    @IBAction func onTouchSaveData(_ sender: UIButton) {
        guard let brand = brandTextField.text, !brand.isEmpty else {
            showAlert(with: "Fill brand")
            return
        }
        
        guard let model = modelTextField.text, !model.isEmpty else {
            showAlert(with: "Fill model")
            return
        }
        
        guard let releaseDate = dateFormat.date(from: releaseDateTextField.text!) else {
            showAlert(with: "Fill release date")
            return
        }
        
        if let carForEdit = carForEdit {
            carForEdit.brand = brand
            carForEdit.model = model
            carForEdit.releaseDate = releaseDate
            delegate?.refreshList()
        } else {
            let car = Car(brand: brand, model: model, releaseDate: releaseDate)
            delegate?.onCreatedNew(car: car)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension UIViewController {

    func showAlert(with title: String) {
        let alert = UIAlertController(title: "Missing data", message: title,
                                      preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default)
        alert.addAction(actionOk)
        present(alert, animated: true, completion: nil)
    }

}


