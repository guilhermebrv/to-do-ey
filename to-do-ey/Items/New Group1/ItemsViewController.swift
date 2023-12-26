//
//  HomeViewController.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 13/12/2023.
//

import UIKit

class ItemsViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var screen: ItemsView?
    private var category: Category
    private var viewModel: ItemsViewModel = ItemsViewModel()
    
    init(category: Category) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        screen = ItemsView()
        view = screen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        dismissKeyBoard()
        signProtocols()
    }
}

extension ItemsViewController {
    private func signProtocols() {
        screen?.itemsTableView.delegate = self
        screen?.itemsTableView.dataSource = self
        screen?.searchBar.delegate = self
    }
    
    private func setupNavigationBar() {
        navigationItem.title = category.name
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(tappedAddItemButton))
    }
    
    @objc private func tappedAddItemButton() {
        AlertAddNew(controller: self).showAlert(title: "Enter a new item:") { itemName in
            if let itemName = itemName, !itemName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                let itemToSave = Item(context: self.context)
                itemToSave.title = itemName
                itemToSave.checked = false
                itemToSave.parentCategory = self.category
                self.viewModel.items.append(itemToSave)
                self.viewModel.saveUserData()
                DispatchQueue.main.async {
                    self.screen?.itemsTableView.reloadData()
                }
            }
        }
    }
}

// MARK: SEARCH BAR METHODS
extension ItemsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterSearchText(text: searchText)
        screen?.itemsTableView.reloadData()
        if searchText.isEmpty {
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: TABLE VIEW METHODS
extension ItemsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if screen?.searchBar.text != "" {
            return viewModel.numberOfRowsInSection(filtering: true, parentCategory: category)
        }
        return viewModel.numberOfRowsInSection(filtering: false, parentCategory: category)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.identifier, for: indexPath) as? CategoriesTableViewCell
        cell?.selectionStyle = .none
        
        if indexPath.row <= viewModel.filterItems.count - 1 && screen?.searchBar.text != "" && category == viewModel.filterItems[indexPath.row].parentCategory {
            let item = viewModel.filterItems[indexPath.row]
            cell?.setupItemCell(itemType: item)
            cell?.accessoryType = item.checked ? .checkmark : .none
            return cell ?? UITableViewCell()
        }
        if viewModel.readUserData()[indexPath.row].parentCategory == category {
            let item = viewModel.readUserData()[indexPath.row]
            cell?.setupItemCell(itemType: item)
            cell?.accessoryType = item.checked ? .checkmark : .none
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem: Item
        if let searchText = screen?.searchBar.text, !searchText.isEmpty {
            selectedItem = viewModel.filterItems[indexPath.row]
        } else {
            selectedItem = viewModel.readUserData()[indexPath.row]
        }
        selectedItem.checked.toggle()
        viewModel.saveUserData()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
