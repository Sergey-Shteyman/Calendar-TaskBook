//
//  TaskViewController.swift
//  TaskBook
//
//  Created by Сергей Штейман on 03.05.2022.
//

import UIKit

// MARK: - TaskViewControllerProtocol
protocol TaskViewControllerProtocol: AnyObject {
    func becomeResponder()
}

// MARK: - TaskViewController
final class TaskViewController: UIViewController {
    
    var presenter: TaskPresenter?
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .boldSystemFont(ofSize: 30)
        textField.textAlignment = .center
        textField.placeholder = "N A M E  T A S K"  // To Enum
        textField.textColor = .black
//        textField.text = "N A M E  T A S K"
        textField.tintColor = .red
        textField.keyboardType = .default
        textField.backgroundColor = .clear
        textField.delegate = self
        return textField
    }()
    
    private lazy var containerTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.layer.borderWidth = 2
        textField.text = "YOR:TIME"                 // To Enum
        textField.textColor = .systemRed
        textField.font = .boldSystemFont(ofSize: 25)
        textField.layer.cornerRadius = 10
//        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderColor = UIColor.darkGray.cgColor
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        let localeIdentifire = DateHelperElements.localeIdentifireRU.rawValue
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: localeIdentifire)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(stringTime), for: .valueChanged)
        return datePicker
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 120)
        label.textAlignment = .center
        label.text = "LET'S  MOVE"
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.tintColor = .red
        textView.keyboardType = .default
        textView.backgroundColor = .clear
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 20
        textView.textColor = .systemRed
        textView.font = .boldSystemFont(ofSize: 30)
        textView.textAlignment = .center
        textView.text = "\nY O U R  \nD E S C R I P T I O N" //  To Enum
        textView.delegate = self
        return textView
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    @objc func doneAction() {
        containerTextField.resignFirstResponder()
    }
    
    @objc func stringTime() {
        let dateFormater = DateFormatter()
        dateFormater.timeStyle = .short
        dateFormater.dateStyle = .none
        dateFormater.locale = Locale(identifier: "ru_RU") // To model
        let stringTime = dateFormater.string(from: datePicker.date)
        containerTextField.text = stringTime
    }
}

// MARK: - TaskViewControllerProtocol Impl
extension TaskViewController: TaskViewControllerProtocol {
    
    func becomeResponder() {
        titleTextField.becomeFirstResponder()
    }
}

// MARK: - UITextFieldDelegate Impl
extension TaskViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let textFieldText = titleTextField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                    return false
            }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 15                                // To Enum
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
}

// MARK: - UITextViewDelegate Impl
extension TaskViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTextView.text == "\nY O U R  \nD E S C R I P T I O N" {
            descriptionTextView.text = ""
            descriptionTextView.textColor = .black
            descriptionTextView.font = .boldSystemFont(ofSize: 20)
            descriptionTextView.textAlignment = .left
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextView.text.isEmpty {
            descriptionTextView.textColor = .systemRed
            descriptionTextView.font = .boldSystemFont(ofSize: 30)
            descriptionTextView.textAlignment = .center
            descriptionTextView.text = "\nY O U R  \nD E S C R I P T I O N"
        }
    }
}

// MARK: Private Methods
private extension TaskViewController {
    
    func setupViewController() {
        view.backgroundColor = .systemGray6
        view.addTapGestureToHideKeyboard()
        inputViewDataPicker()
        setupDoneButtonForDataPicker()
        addSubViews()
        addConstraints()
    }
    
    func inputViewDataPicker() {
        containerTextField.inputView = datePicker
    }
    
    func setupDoneButtonForDataPicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                                 target: self, action: #selector(doneAction))
        doneButton.customView?.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        doneButton.tintColor = .systemRed
        toolBar.setItems([flexSpace, doneButton], animated: true)
        containerTextField.inputAccessoryView = toolBar
    }
    
    func addSubViews() {
        let arraySubViews = [label, titleTextField, containerTextField,
                             descriptionTextView]
        view.myAddSubViews(from: arraySubViews)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            
            titleTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            containerTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 90),
            containerTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerTextField.widthAnchor.constraint(equalToConstant: 120),
            containerTextField.heightAnchor.constraint(equalToConstant: 80),
            
            descriptionTextView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 90),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
}
