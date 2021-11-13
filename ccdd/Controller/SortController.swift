//
//  SortController.swift
//  ccdd
//
//  Created by Zakirov Tahir on 10.11.2021.
//

import UIKit

class SortController: UITableViewController {
    
    var sortType = [SortedModel(name: "По алфавиту", isSelected: false), SortedModel(name: "По дню рождения", isSelected: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Сортировка"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .done, target: self, action: #selector(backButton))
        
        tableView.separatorStyle = .none
        tableView.register(SortCell.self, forCellReuseIdentifier: "cell")
    }
}

extension SortController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortType.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SortCell
        
        cell.sortLabel.text = sortType[indexPath.row].name
        cell.ratioImageView.image = sortType[indexPath.row].isSelected ? UIImage(named: "selectedRatio") : UIImage(named: "unselectedRatio")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in sortType.enumerated() { // TODO: Выглядить костыльно, нужно зарефакторить
            sortType[i.offset].isSelected = false
        }
        
        sortType[indexPath.row].isSelected = !sortType[indexPath.row].isSelected
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension SortController {
    @objc func backButton() {
        dismiss(animated: true, completion: nil)
    }
}
