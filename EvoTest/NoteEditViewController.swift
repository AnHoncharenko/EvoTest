//
//  NoteEditViewController.swift
//  EvoTest
//
//  Created by Anton Honcharenko on 5/14/19.
//  Copyright © 2019 Anton Honcharenko. All rights reserved.
//


import UIKit

class NoteEditViewController: UIViewController {
    enum Operation {
        case add
        case edit
        case read
    }
    
    @IBOutlet weak var textView: UITextView!
    var model: NoteModel!
    var saveAction: ((String) -> Void)!
    var operation: Operation = .read
    
    static func show(on viewController: UIViewController, model: NoteModel, operation: Operation, saveAction: @escaping (String) -> Void) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "edit") as! NoteEditViewController
        vc.saveAction = saveAction
        vc.model = model
        vc.operation = operation
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = model.text
        textView.isEditable = operation != .read
        switch operation {
        case .add:
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(rightButtonAction))
        case .edit:
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(rightButtonAction))
        case .read:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                                target: self,
                                                                action:  #selector(share))
            
        }
    
    }
    
    @objc func rightButtonAction() {
        saveAction(textView.text)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func share() {
        let vc = UIActivityViewController(activityItems: [model.text], applicationActivities: [])
        present(vc, animated: true, completion: nil)
    }

}


