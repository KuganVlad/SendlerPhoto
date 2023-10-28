//
//  CustomTableViewCell.swift
//  SendlerPhoto
//
//  Created by Vlad Kugan on 28.10.23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var textLabelCell: UILabel!
    @IBOutlet weak var idLabelCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(with item: Content) {
        idLabelCell.text = "\(item.id)"
        textLabelCell.text = item.name
            if let imageURL = item.image {
                loadImage(fromURL: imageURL)
            } else {
                imageCell.image = UIImage(named: "placeholderImage")
            }
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func loadImage(fromURL url: String) {
        guard let imageURL = URL(string: url) else {
            imageCell.image = UIImage(named: "placeholderImage")
            return
        }
        URLSession.shared.dataTask(with: imageURL) { [weak self] (data, _, error) in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.imageCell.image = image
                }
            }
        }.resume()
    }
    
}
