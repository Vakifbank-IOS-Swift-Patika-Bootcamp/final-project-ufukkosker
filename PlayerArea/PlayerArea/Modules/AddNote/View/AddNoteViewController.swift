//
//  AddNoteViewController.swift
//  PlayerArea
//
//  Created by Ufuk Köşker on 18.12.2022.
//

import UIKit

protocol AddNoteViewControllerProtocol: AnyObject {
    func didSave()
}

class AddNoteViewController: UIViewController {
    
    @IBOutlet private weak var titleLabeView: UIView!
    @IBOutlet private weak var textFieldView: UIView!
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var descriptionTitleView: UIView!
    @IBOutlet private weak var textViewView: UIView!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var buttonView: UIView!
    @IBOutlet private weak var addNoteButton: UIButton!
    
    weak var delegate: AddNoteViewControllerProtocol?
    var viewModel: AddNoteViewModelProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTitle()
        hideKeyboardWhenTappedAround()
    }
    
    private func setupUI() {
        titleLabeView.layer.cornerRadius = 8
        textFieldView.layer.cornerRadius = 8
        descriptionTitleView.layer.cornerRadius = 8
        textViewView.layer.cornerRadius = 8
        textView.layer.cornerRadius = 8
        buttonView.layer.cornerRadius = 8
        addNoteButton.layer.cornerRadius = 8
    }
    
    private func setupTitle() {
        guard let title = viewModel?.coreDataNoteModel?.title,
              let note = viewModel?.coreDataNoteModel?.note
        else { return }
        titleTextField.text = title
        textView.text = note
    }
    
    @IBAction func didTappedAddNoteButton(_ sender: Any) {
        if !(titleTextField.text?.isEmpty ?? true) && !textView.text.isEmpty {
            viewModel?.coreDataNoteModel?.title = titleTextField.text
            viewModel?.coreDataNoteModel?.note = textView.text
            viewModel?.noteContains()
        } else {
            let alert = UIAlertController(title: "Hata", message: "Tüm alanları doldurmalısın", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okButton)
            self.present(alert, animated: true)
        }
    }
}

extension AddNoteViewController: AddNoteViewModelDelegate {
    func handle(output: AddNoteViewModelOutput) {
        switch output {
        case .didSave:
            delegate?.didSave()
            dismiss(animated: true)
        }
    }
}
