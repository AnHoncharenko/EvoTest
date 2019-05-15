//
//  ViewController.swift
//  EvoTest
//
//  Created by Anton Honcharenko on 5/14/19.
//  Copyright © 2019 Anton Honcharenko. All rights reserved.
//

import UIKit
import RealmSwift

class NoteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let realm = try! Realm()
    var data: Results<NoteModel>!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = realm.objects(NoteModel.self).sorted(byKeyPath: "date", ascending: false)
        title = "Заметки"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        let rightButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(addNoteAction))
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    @objc func addNoteAction() {
        let model = NoteModel()
        NoteEditViewController.show(on: self, model: model, operation: .add, saveAction: { [weak self] text in
            try! self?.realm.write {
                model.text = text
                self?.realm.add(model)
            }
            self?.tableView.reloadData()
        })
    }
    
    func delete(_ model: NoteModel) {
        try! realm.write {
            realm.delete(model)
        }
    }
}

extension NoteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoteCell
        cell.setup(model: data[indexPath.row])
        return cell
    }
    
}

extension NoteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        NoteEditViewController.show(on: self, model: data[indexPath.row], operation: .read, saveAction: { [weak self] _ in })
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let model = data[indexPath.row]
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action , indexPath) in
            self.delete(model)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            NoteEditViewController.show(on: self, model: model, operation: .edit, saveAction: { [weak self] text in
                try! self?.realm.write {
                    model.text = text
                }
                self?.tableView.reloadData()
            })
        }
        edit.backgroundColor = UIColor.blue
        return [delete, edit]
    }

}

