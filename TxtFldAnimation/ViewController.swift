//
//  ViewController.swift
//  TxtFldAnimation
//
//  Created by MhMuD SalAh on 05/04/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var centerVerticalConstrain: NSLayoutConstraint!
    @IBOutlet weak var viewlabel: UIView!
    @IBOutlet weak var lblPlaceHolder: UILabel!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var viewText: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }
    
    func setupTextField() {
        hideKeyboardWhenTappedAround()
        txtField.delegate = self
        viewText.layer.masksToBounds = false
        viewText.layer.cornerRadius = 7
        viewText.layer.borderWidth = 0.5
        viewText.layer.borderColor = UIColor.black.cgColor
        txtField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        centerVerticalConstrain.isActive = true
        lblPlaceHolder.textColor = .black
        lblPlaceHolder.text = "Email"
        viewlabel.translatesAutoresizingMaskIntoConstraints = false
        centerVerticalConstrain.isActive = true
    }
    
    @objc func handleTextInputChange() {
        
    }
    
    func raisePlaceHolder() {
        view.bringSubviewToFront(viewlabel)
        view.layoutIfNeeded()
        lblPlaceHolder.textColor = .black
        viewText.layer.borderColor = UIColor.black.cgColor
        centerVerticalConstrain.constant = -17.5
        UIView.animate(withDuration: 0.2, delay: 0.1, options: [], animations: { [weak self] in self?.view.layoutIfNeeded() }, completion: nil)
    }
    
    func downPlaceHolder() {
        view.layoutIfNeeded()
        centerVerticalConstrain.constant = 0
        lblPlaceHolder.textColor = .red
        viewText.layer.borderColor = UIColor.red.cgColor
        UIView.animate(withDuration: 0.2, delay: 0.1, options: [], animations: { [weak self] in self?.view.layoutIfNeeded() }, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
            view.bringSubviewToFront(viewText)
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        raisePlaceHolder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField.text!.isEmpty {
            downPlaceHolder()
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
