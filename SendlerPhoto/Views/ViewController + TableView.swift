//
//  ViewController + TableView.swift
//  SendlerPhoto
//
//  Created by Vlad Kugan on 28.10.23.
//

import UIKit

extension ViewController : UITableViewDataSource, UITableViewDelegate{
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        registerCell()
        fetchData()
    }
    
    func registerCell() {
        tableView.register(UINib(nibName: String(describing: CustomTableViewCell.self), bundle: nil), forCellReuseIdentifier: "customCell")
    }
    
    private func fetchData() {
        viewModel.fetchData { [weak self] (data, error) in
            if let data = data {
                self?.welcomData = data
                if let welcomeData = self?.welcomData {
                    // Используйте flatMap для объединения всех массивов content в один массив
                    self?.contentData = welcomeData.flatMap { $0.content }
                }
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
            }
        }
    }
    
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfTotalPage(numberPage: viewModel.numberOfPage())
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(viewModel.numberOfPageSize(numberPage: viewModel.numberOfPage()),
                    viewModel.numberOfTotalElement(numberPage: viewModel.numberOfPage()))
    }
    
   
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ("Page: \(section)")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedItemId = nil
        let selectedItem = contentData[indexPath.row]
        selectedItemId = selectedItem.id

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            present(imagePicker.imagePicker, animated: true, completion: nil)
        } else {
            print("Camera not available")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell else{
            return UITableViewCell()
        }
        
        
        if let contentItem = contentData[safe: indexPath.row] {
                cell.configureCell(with: contentItem)
        } else {
                cell.configureCell(with: Content(id: 0, name: "No Data", image: nil))
            }
        
        
        return cell
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
