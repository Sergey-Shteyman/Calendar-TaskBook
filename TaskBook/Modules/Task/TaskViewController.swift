//
//  TaskViewController.swift
//  TaskBook
//
//  Created by Сергей Штейман on 03.05.2022.
//

import UIKit

// MARK: - TaskViewControllerState
enum TaskViewControllerState {
    case create
    case read
}

// MARK: - TaskViewControllerDelegate
protocol TaskViewControllerDelegate: AnyObject {
    func didCreateTask(viewModel: TaskViewModel)
}

// MARK: - TaskViewControllerProtocol
protocol TaskViewControllerProtocol: AnyObject {
    func becomeResponder()
    func update(viewModel: TaskViewModel)
    func callDelagate(viewModel: TaskViewModel)
}

// MARK: - TaskViewController
final class TaskViewController: UIViewController {
    
    var presenter: TaskPresenter?
    weak var delegate: TaskViewControllerDelegate?
    
    private var screenState: TaskViewControllerState = .create
    
    private let localeId = DateHelperElements.localeIdentifireRU.rawValue
    private let placeholderTitle = TaskElements.placeholderTitle
    private let timeTitle = TaskElements.timeTitle
    private let moveTitle = TaskElements.moveTitle
    private let descriptionTitle = TaskElements.descriptionTitle
    private let limitChars = TaskElements.limitChars
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .boldSystemFont(ofSize: 30)
        textField.textAlignment = .center
        textField.placeholder = placeholderTitle
        textField.textColor = .black
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
        textField.text = timeTitle
        textField.textColor = .systemRed
        textField.font = .boldSystemFont(ofSize: 25)
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.darkGray.cgColor
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: localeId)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(stringTime), for: .valueChanged)
        return datePicker
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 120)
        label.textAlignment = .center
        label.text = moveTitle
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.tintColor = .red
        textView.keyboardType = .default
        textView.backgroundColor = .systemGray6
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 20
        textView.textColor = .systemRed
        textView.font = .boldSystemFont(ofSize: 30)
        textView.textAlignment = .center
        textView.text = descriptionTitle
        textView.delegate = self
        return textView
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareScreenWithState()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isBeingDismissed {
            print(#function)
        }
        presenter?.viewDidDisappear(title: titleTextField.text, description: descriptionTextView.text)
    }

    @objc func doneAction() {
        containerTextField.resignFirstResponder()
    }
    
    @objc func stringTime() {
        let stringTime = presenter?.fetchStringTime(localeId, datePicker.date)
        containerTextField.text = stringTime
    }
}

// MARK: - Public Methods
extension TaskViewController {
    
    func setupScreenState(_ state: TaskViewControllerState) {
        screenState = state
    }
}

// MARK: - TaskViewControllerProtocol Impl
extension TaskViewController: TaskViewControllerProtocol {
    
    func becomeResponder() {
        titleTextField.becomeFirstResponder()
    }
    
    func update(viewModel: TaskViewModel) {
        titleTextField.text = viewModel.nameTask
        descriptionTextView.text = viewModel.description
    }
    
    func callDelagate(viewModel: TaskViewModel) {
        delegate?.didCreateTask(viewModel: viewModel)
    }
}

// MARK: - UITextFieldDelegate Impl
extension TaskViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let text = titleTextField.text
        guard let limit = presenter?.limitChars(textInput: text,
                                                shouldChangeCharactersIn: range,
                                                replacementString: string,
                                                limit: limitChars) else {
            return Bool()
        }
        return limit
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
}

// MARK: - UITextViewDelegate Impl
extension TaskViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTextView.text == descriptionTitle {
            setupPlaceHolderForTextView("", .black, 20, .left)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextView.text.isEmpty {
            setupPlaceHolderForTextView(descriptionTitle, .systemRed, 30, .center)
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
    
    func prepareScreenWithState() {
        switch screenState {
        case .create:
            break
        case .read:
            presenter?.passedModel()
        }
    }
    
    func setupPlaceHolderForTextView(_ text: String,
                                     _ textColor: UIColor,
                                     _ fontSize: CGFloat,
                                     _ alignment: NSTextAlignment) {
        descriptionTextView.text = text
        descriptionTextView.textColor = textColor
        descriptionTextView.font = .boldSystemFont(ofSize: fontSize)
        descriptionTextView.textAlignment = alignment
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
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
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
            
            descriptionTextView.topAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -200),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor)
        ])
    }
}
