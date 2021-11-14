//
//  ContactsController.swift
//  ccdd
//
//  Created by Zakirov Tahir on 05.11.2021.
//

import UIKit
import SkeletonView

class ContactsController: UIViewController {
    
    var emptyResultView = ContactEmptyResultView()
    let sortController = SortController()
    var contacts: [ContactsItem]?
    private var resultContacts = [ContactsItem]()
    private var categoryFilterContacts = [ContactsItem]()
    private var isFirstLoad = false
    private var isFilteredByCaregory = false
    var category = ["Все", "Technician", "Orchestrator", "Strategist", "Executive", "Developer", "Producer", "Agent", "Consultant", "Administrator", "Designer", "Analyst", "Manager", "Coordinator", "Representative", "Supervisor", "Facilitator", "Specialist", "Engineer", "Planner"]
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    let menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
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
        menuSetupView()
        setupSearch()
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emptyResultView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        if isFirstLoad == false {
            collectionView.isSkeletonable = true
            collectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .gray, secondaryColor: .lightGray), animation: nil, transition: .crossDissolve(0.2))
        }
    }
    
    
    private func setupView() {
        sortController.delegate = self
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        view.addSubview(menuCollectionView)
        
        menuCollectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: collectionView.topAnchor, trailing: view.trailingAnchor, size: .init(width: 0, height: 50))
        collectionView.anchor(top: menuCollectionView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ContactCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.refreshControl = refreshController
    }
    
    private func menuSetupView() {
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        menuCollectionView.isPagingEnabled = true
        menuCollectionView.showsHorizontalScrollIndicator = false
        menuCollectionView.register(MenuContactCell.self, forCellWithReuseIdentifier: "menuCell")
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
                    self.collectionView.stopSkeletonAnimation()
                    self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                    self.isFirstLoad = true
                    self.collectionView.reloadData()
                }
                
            } catch let error {
                print("LOG error: Ошибочка вышла :( \(error)")
            }
            
            
        }.resume()
    }
    
}

// MARK: - collectionView delegate and dataSource methods
extension ContactsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.menuCollectionView {
            return category.count
        } else {
            if isFiltering {
                
                if resultContacts.isEmpty {
                    view.addSubview(emptyResultView)
                } else {
                    emptyResultView.removeFromSuperview()
                }
                
                return resultContacts.count
            } else if isFilteredByCaregory {
                return categoryFilterContacts.count
            }
            return contacts?.count ?? 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.menuCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! MenuContactCell
            
            cell.titleLabel.text = category[indexPath.row]
            
            if(indexPath.row == 0) {
                cell.lineView.isHidden = false
            } else {
                cell.lineView.isHidden = true
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ContactCell
            
            var contact: ContactsItem
            
            if isFiltering {
                contact = resultContacts[indexPath.row]
            } else if isFilteredByCaregory {
                contact = categoryFilterContacts[indexPath.item]
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
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.menuCollectionView {
            if category[indexPath.item] == "Все" {
                isFilteredByCaregory = false
                fetchData()
            } else {
                isFilteredByCaregory = true
                sortArrayByPosition(position: category[indexPath.item])
            }
        } else {
            let controller = ProfileController()
            guard let contact = contacts else { return }
            
            if isFilteredByCaregory {
                controller.contact = categoryFilterContacts[indexPath.item]
            } else {
                controller.contact = contact[indexPath.row]
            }
            
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.menuCollectionView {
            return .init(width: textWidth(text: category[indexPath.item], font: .boldSystemFont(ofSize: 16)) + 24, height: 50)
        } else {
            return .init(width: self.view.frame.width, height: 100)
        }
    }
    
}


// MARK: - Actions
extension ContactsController {
    @objc func updatePage() {
        fetchData()
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
    
    func textWidth(text: String, font: UIFont?) -> Int {
        let attributes = font != nil ? [NSAttributedString.Key.font: font] : [:]
        return Int(text.size(withAttributes: attributes).width)
    }
    
    func sortArrayByPosition(position: String) {
        guard let contacts = contacts else { return }
        
        categoryFilterContacts = (contacts.filter({ (contact: ContactsItem) in
            return contact.position!.lowercased().contains(position.lowercased())
        }))
        
        collectionView.reloadData()
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
        
        collectionView.reloadData()
        
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        
        let navController = UINavigationController(rootViewController: sortController)
        
        if let sheet = navController.presentationController as? UISheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        
        present(navController, animated: true, completion: nil)
    }
}


extension ContactsController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "cell"
    }
}

extension ContactsController: SortDelegate {
    func sortedByAlphabet() {
        if isFilteredByCaregory {
            categoryFilterContacts = categoryFilterContacts.sorted { $0.firstName ?? "" < $1.firstName ?? "" }
        } else {
            contacts = contacts?.sorted { $0.firstName ?? "" < $1.firstName ?? "" }
        }
        
        collectionView.reloadData()
    }
    
    func sortedByBirthday() {
        if isFilteredByCaregory {
            categoryFilterContacts = categoryFilterContacts.sorted { $0.birthday ?? "" < $1.birthday ?? "" }
        } else {
            contacts = contacts?.sorted { $0.birthday ?? "" < $1.birthday ?? "" }
        }
        
        collectionView.reloadData()
    }
}
