//
//  CategoryViewController.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 20/12/2023.
//

import UIKit

class CategoryViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var screen: CategoryView?
    private var viewModel: CategoryViewModel = CategoryViewModel()
    
    override func loadView() {
        screen = CategoryView()
        view = screen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyBoard()
        signProtocols()
    }
}

extension CategoryViewController {
    private func signProtocols() {
        screen?.categoriesTableView.delegate = self
        screen?.categoriesTableView.dataSource = self
        screen?.searchBar.delegate = self
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBlue.withAlphaComponent(0.6)
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,
                                          NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24, weight: .bold)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .white
        navigationItem.hidesBackButton = true
        navigationItem.title = "Todoey ☑️"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(tappedAddCategoryButton))
    }
    
    @objc private func tappedAddCategoryButton() {
        AlertAddNew(controller: self).showAlert(title: "Enter a new category:") { categoryName in
            if let categoryName = categoryName, !categoryName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                let categoryToSave = Category(context: self.context)
                categoryToSave.name = categoryName
                self.viewModel.categories.append(categoryToSave)
                self.viewModel.saveUserData()
                DispatchQueue.main.async {
                    self.screen?.categoriesTableView.reloadData()
                }
            }
        }
    }
}

extension CategoryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterSearchText(text: searchText)
        screen?.categoriesTableView.reloadData()
        if searchText.isEmpty {
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if screen?.searchBar.text != "" {
            return viewModel.numberOfRowsInSection(filtering: true)
        }
        return viewModel.numberOfRowsInSection(filtering: false)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.identifier, for: indexPath) as? CategoriesTableViewCell
        cell?.selectionStyle = .none
        if screen?.searchBar.text != "" {
            let category = viewModel.filterCategories[indexPath.row]
            cell?.setupCategoryCell(itemType: category)
            return cell ?? UITableViewCell()
        }
        let category = viewModel.readData()[indexPath.row]
        cell?.setupCategoryCell(itemType: category)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = ItemsViewController(category: viewModel.categories[indexPath.row])
        navigationController?.pushViewController(item, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        //context.delete(viewModel.categories[indexPath.row])
        //viewModel.categories.remove(at: indexPath.row)
    }
}
