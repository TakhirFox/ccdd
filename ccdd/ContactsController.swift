//
//  ContactsController.swift
//  ccdd
//
//  Created by Zakirov Tahir on 05.11.2021.
//

import UIKit

class ContactsController: UITableViewController {

    var contacts = [ContactsItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        fetchData()
    }
    
    private func setupView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func fetchData() {
        guard let urlString = URL(string: "https://stoplight.io/mocks/kode-education/trainee-test/25143926/users") else { return }
        
        URLSession.shared.dataTask(with: urlString) { data, response, error in
            
            guard let data = data else {
                return
            }
                        
            do {
                let json = try JSONDecoder().decode(Contacts.self, from: data)
                
                self.contacts = json.items!
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let error {
                print("LOG error: Ошибочка вышла :( \(error)")
            }
            
            
        }.resume()
    }

}

// MARK: - tableView delegate and dataSource methods
extension ContactsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let contacts = contacts[indexPath.row].id
        print(contacts)
        
        return cell
    }
    
}

