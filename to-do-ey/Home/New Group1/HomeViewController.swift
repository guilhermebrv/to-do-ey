//
//  HomeViewController.swift
//  to-do-ey
//
//  Created by Guilherme Viana on 13/12/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    private var screen: HomeView?
    private var viewModel: HomeViewModel = HomeViewModel()
    
    override func loadView() {
        screen = HomeView()
        view = screen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        signProtocols()
    }
}

extension HomeViewController {
    private func signProtocols() {
        screen?.categoriesTableView.delegate = self
        screen?.categoriesTableView.dataSource = self
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
        navigationItem.title = "Todoey"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(tappedAddCategoryButton))
    }
    @objc private func tappedAddCategoryButton() {
        AlertAddNewCategory(controller: self).showAlert(title: "Enter a new category:") { categoryName in
            if let categoryName = categoryName, !categoryName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                self.viewModel.categories.append(Item(name: categoryName, checked: false))
                self.viewModel.saveUserData()
                DispatchQueue.main.async {
                    self.screen?.categoriesTableView.reloadData()
                }
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.identifier, for: indexPath) as? CategoriesTableViewCell
        let category =  viewModel.getCategory()[indexPath.row]
        cell?.setupCell(category: category)
        cell?.selectionStyle = .none
        cell?.accessoryType = category.checked ? .checkmark : .none
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.categories[indexPath.row].checked.toggle()
        viewModel.saveUserData()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
