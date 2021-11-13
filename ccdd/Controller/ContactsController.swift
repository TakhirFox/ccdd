//
//  ContactsController.swift
//  ccdd
//
//  Created by Zakirov Tahir on 05.11.2021.
//

import UIKit
import SkeletonView

class ContactsController: UITableViewController {
    
    var contacts: [ContactsItem]?
    private var resultContacts = [ContactsItem]()
    private var isFirstLoad = false
    
    lazy var refreshController: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(updatePage), for: .valueChanged)
        return view
    }()
    
    var searchController = UISearchController(searchResultsController: nil)
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }

    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSearch()
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isFirstLoad == false {
            tableView.isSkeletonable = true
            tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .gray, secondaryColor: .lightGray), animation: nil, transition: .crossDissolve(0.2))
        }
        
        
        
    }

    
    private func setupView() {
        tableView.register(ContactCell.self, forCellReuseIdentifier: "cell")
        tableView.refreshControl = refreshController
    }
    
    private func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Введи имя, тег, почту..."
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.setImage(UIImage(named: "searchFilter"), for: .bookmark, state: .normal)
        searchController.searchBar.delegate = self
        searchController.searchBar.showsBookmarkButton = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
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
                    self.tableView.stopSkeletonAnimation()
                    self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                    self.isFirstLoad = true
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
        if isFiltering {
            return resultContacts.count
        }
        return contacts?.count ?? 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactCell
        
        var contact: ContactsItem
        
        if isFiltering {
            contact = resultContacts[indexPath.row]
        } else {
            contact = contacts?[indexPath.row] ?? ContactsItem(id: "", avatarUrl: "", firstName: "", lastName: "", userTag: "", department: "", position: "", birthday: "", phone: "")
        }
        
        cell.fullName.text = "\(contact.firstName!) \(contact.lastName!)"
        cell.position.text = contact.position
        cell.userTag.text = contact.userTag
        
        
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: contact.avatarUrl ?? "") else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                cell.avatar.image = UIImage(data: imageData)
            }
        }
        
        
        
        cell.birthday.text = dateFormatter(inputDate: contact.birthday ?? "")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ProfileController()
        
        guard let contact = contacts else { return }
        
        controller.contact = contact[indexPath.row]
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}


// MARK: - Actions
extension ContactsController {
    @objc func updatePage() {
        self.refreshController.endRefreshing()
    }
    
    private func dateFormatter(inputDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: inputDate) ?? Date()
        dateFormatter.dateFormat = "d MMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date)
    }
}

// MARK: - UISearchResultsUpdating
extension ContactsController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        filterContentSearchText(text: text)
    }
    
    func filterContentSearchText(text: String) {
        resultContacts = (contacts?.filter({ (contact: ContactsItem) in
            return contact.firstName!.lowercased().contains(text.lowercased())
            || contact.lastName!.lowercased().contains(text.lowercased())
            || contact.position!.lowercased().contains(text.lowercased())
            
        }))!
        
        tableView.reloadData()

    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        let sortController = SortController()
        let navController = UINavigationController(rootViewController: sortController)
        
        if let sheet = navController.presentationController as? UISheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        
        present(navController, animated: true, completion: nil)
    }
}


extension ContactsController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "cell"
    }
}
