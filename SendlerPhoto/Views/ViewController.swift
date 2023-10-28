//
//  ViewController.swift
//  SendlerPhoto
//
//  Created by Vlad Kugan on 28.10.23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
       
    
    var welcomData: [Welcome] = []
    var contentData: [Content] = []
    
    var viewModel = MainViewModel()
    let imagePicker = ImagePicker()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
        setupView()
        imagePicker.setupImagePicker()
        
    }
    
    func setupView() {
        title = "Send Photo Table"
    }
    
    private func fetchData() {
        viewModel.fetchData { [weak self] (data, error) in
            if let data = data {
                self?.welcomData = data
                if let welcomeData = self?.welcomData {
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
    

}

