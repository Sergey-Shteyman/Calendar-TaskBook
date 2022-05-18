//
//  TaskPresenter.swift
//  TaskBook
//
//  Created by Сергей Штейман on 03.05.2022.
//

import Foundation

// MARK: - TaskPresenterProtocol
protocol TaskPresenterProtocol: AnyObject {
    func firstOpen()
    func limitChars(textInput text: String?,
                    shouldChangeCharactersIn range: NSRange,
                    replacementString string: String,
                    limit: Int) -> Bool
    func fetchStringTime(_ localeId: String, _ date: Date)
    func passedModel()
    func viewDidDisappear(title: String?, time: String?, description: String?)
}

// MARK: - TaskPresenter
final class TaskPresenter {
    
    weak var viewController: TaskViewController?
    
    private let moduleBuilder: Buildable
    private let userDefaults: UserDefaultsManagerProtocol
    private let taskViewModel: TaskViewModel?
    private let dateFormater = DateFormatter()
    
    init(moduleBuilder: Buildable,
         userDefaults: UserDefaultsManagerProtocol,
         taskViewModel: TaskViewModel? = nil) {
        self.moduleBuilder = moduleBuilder
        self.userDefaults = userDefaults
        self.taskViewModel = taskViewModel
    }
}

// MARK: - TaskPresenterProtocol Impl
extension TaskPresenter: TaskPresenterProtocol {
    
    func firstOpen() {
        viewController?.becomeResponder()
    }
    
    func limitChars(textInput text: String?,
                    shouldChangeCharactersIn range: NSRange,
                    replacementString string: String,
                    limit: Int) -> Bool {
        guard let textFieldText = text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                    return false
            }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= limit
    }
    
    func fetchStringTime(_ localeId: String, _ date: Date) {
        dateFormater.timeStyle = .short
        dateFormater.dateStyle = .none
        dateFormater.locale = Locale(identifier: localeId)
        let stringTime = dateFormater.string(from: date)
        viewController?.showTime(with: stringTime)
    }
    
    func passedModel() {
        guard let viewModel = taskViewModel else {
            return
        }
        viewController?.update(viewModel: viewModel)
    }
    
    func viewDidDisappear(title: String?, time: String?, description: String?) {
        if var  viewModel = taskViewModel {
            viewModel.nameTask = title ?? ""
            viewModel.description = description ?? ""
            viewModel.time = time ?? ""
            viewController?.callDelagate(viewModel: viewModel)
            return
        }
        let id = UUID().uuidString
        let viewModel = TaskViewModel(id: id,
                                      nameTask: title ?? "",
                                      time: time ?? "",
                                      date: "",
                                      description: description ?? "")
        viewController?.callDelagate(viewModel: viewModel)
    }
}

// MARK: - Private Methods
private extension TaskPresenter {
    
}
