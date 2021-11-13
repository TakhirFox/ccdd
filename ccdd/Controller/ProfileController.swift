//
//  ProfileController.swift
//  
//
//  Created by Zakirov Tahir on 12.11.2021.
//

import UIKit

class ProfileController: UITableViewController {
    
    var contact: ContactsItem?
    let blurEffect = UIBlurEffect(style: .dark)
    var blurVisualEffectView = UIVisualEffectView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupBlur()
    }
    
}

extension ProfileController {
    private func setupView() {
        tableView.register(ProfileInfoCell.self, forCellReuseIdentifier: "cell1")
        tableView.register(DetailInfoCell.self, forCellReuseIdentifier: "cell2")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .done, target: self, action: #selector(backButton))
    }
    
    private func setupBlur() {
        blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = view.bounds
    }
}

extension ProfileController {
    @objc func backButton() {
        navigationController?.popViewController(animated: true)
    }
    
    private func dateFormatter(inputDate: String, fullDate: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: inputDate) ?? Date()
        
        if fullDate {
            dateFormatter.dateFormat = "d MMMM yyyy"
        } else {
            dateFormatter.dateFormat = "d MMM"
        }
        
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date)
    }
}

extension ProfileController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! ProfileInfoCell
            
            if let contact = contact {
                cell.fullName.text = contact.firstName! + " " + contact.lastName!
                cell.userTag.text = contact.userTag
                cell.position.text = contact.position
                
                let imageUrl = URL(string: contact.avatarUrl!)
                let imageData = try? Data(contentsOf: imageUrl!)
                DispatchQueue.main.async {
                    cell.avatar.image = UIImage(data: imageData!)
                }
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! DetailInfoCell
            
            if indexPath.row == 0 {
                cell.iconView.image = UIImage(named: "starIcon")
                cell.contactLabel.text = dateFormatter(inputDate: contact?.birthday ?? "", fullDate: true)
                cell.birthdayLabel.text = dateFormatter(inputDate: contact?.birthday ?? "")
            } else {
                cell.iconView.image = UIImage(named: "phoneIcon")
                cell.contactLabel.text = contact?.phone
                cell.birthdayLabel.text = ""
            }
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 230
        } else {
            return 80
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            
            
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let numberAction = UIAlertAction(title: contact?.phone, style: .default) { _ in
                self.blurVisualEffectView.removeFromSuperview()
            }
            
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in
                self.blurVisualEffectView.removeFromSuperview()
            }
            
            alertController.addAction(numberAction)
            alertController.addAction(cancelAction)
            
            blurVisualEffectView.frame = view.bounds
            self.view.addSubview(blurVisualEffectView)
            present(alertController, animated: true, completion: nil)
        }
    }
}
