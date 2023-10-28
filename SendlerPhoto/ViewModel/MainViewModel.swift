//
//  MainViewModel.swift
//  SendlerPhoto
//
//  Created by Vlad Kugan on 28.10.23.
//

import UIKit

class MainViewModel{
    
    var welcomData: [Welcome] = []
    var contentData: [Content] = []
    
    func fetchData(completion: @escaping ([Welcome]?, Error?) -> Void) {
        let networkManager = NetworkManager()
        networkManager.fetchData { [weak self] (data: [Welcome]?, error) in
            if let data = data {
                self?.welcomData = data
                completion(data, nil)
            } else if let error = error {
                completion(nil, error)
            }
        }
    }
    
    func numberOfPage() -> Int{
        return welcomData.first?.page ?? 0
    }
    func numberOfPageSize(numberPage: Int) -> Int{
        guard numberPage >= 0, numberPage < welcomData.count else {
                return 20 
            }
        return welcomData[numberPage].pageSize

    }
    func numberOfTotalPage(numberPage: Int) -> Int{
        guard numberPage >= 0, numberPage < welcomData.count else {
                return 0
            }
        return welcomData[numberPage].totalPages

    }
    func numberOfTotalElement(numberPage: Int) -> Int{
        guard numberPage >= 0, numberPage < welcomData.count else {
            return contentData.count
            }
        return welcomData[numberPage].totalElements

    }
}
