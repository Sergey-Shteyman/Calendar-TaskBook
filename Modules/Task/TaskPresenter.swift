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
    func fetchStringTime(_ localeId: String, _ date: Date) -> String
}

// MARK: - TaskPresenter
final class TaskPresenter {
    
    weak var viewController: TaskViewController?
    
    private var moduleBuilder: Buildable?
    
    private let dateFormater = DateFormatter()
    
    init(moduleBuilder: Buildable) {
        self.moduleBuilder = moduleBuilder
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
    
    func fetchStringTime(_ localeId: String, _ date: Date) -> String {
        dateFormater.timeStyle = .short
        dateFormater.dateStyle = .none
        dateFormater.locale = Locale(identifier: localeId)
        let stringTime = dateFormater.string(from: date)
        return stringTime
    }
}

// MARK: - Private Methods
private extension TaskPresenter {
    
}
