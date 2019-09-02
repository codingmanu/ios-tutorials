//
//  ProductCell.swift
//  Tutorial-01
//
//  Created by Manuel S. Gomez on 9/2/19.
//  Copyright © 2019 codingManu. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    private let productImage = UIImageView(image: UIImage(named: "placeholder"))
    private var stack = CellStack()

    /*
     Remove stackview from cell when the cell gets reused, otherwise
     every time we refresh we add more stackviews into the hierarchy.
     */
    override func prepareForReuse() {
        super.prepareForReuse()
        stack.removeFromSuperview()
    }

    func configureWithProduct(_ product: AppleProduct) {
        // Create new stack on every reuse.
        self.stack = CellStack()
        addSubview(stack)

        // Configure the stack's constraints.
        stack.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
        stack.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: 0).isActive = true
        stack.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true

        // Create title label.
        let titleLabel = UILabel()
        titleLabel.text = "\(product.year) \(product.name)"
        titleLabel.textAlignment = .center
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 35).isActive = true
        stack.addArrangedSubview(titleLabel)

        // Configure product image.
        productImage.contentMode = .scaleAspectFit
        productImage.heightAnchor.constraint(lessThanOrEqualToConstant: 150).isActive = true
        stack.addArrangedSubview(productImage)

        /*
         Begin downloading each product's image on a background thread. Result gets processed in the closure.
         If there's any errors downloading the image, replace placeholder image with placeholderError, otherwise
         replace placeholder image with product's image.
         */
        ApiHandler.getProductImage(url: product.imageUrl) { [weak self] (result) in
            // Use commented method to simulate 1 second delay in network request.
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            //DispatchQueue.main.async { [weak self] in
                switch result {
                case .failure(_):
                    self?.replaceCurrentImageWith(UIImage(named: "placeholderError"))
                case .success(let image):
                    self?.replaceCurrentImageWith(image)
                }
            }
        }
    }

    // Animates the swap from placeholder image.
    private func replaceCurrentImageWith(_ image: UIImage?) {
        UIView.transition(with: self.productImage,
                          duration: 0.8,
                          options: .transitionCrossDissolve,
                          animations: {
                            [weak self] in self?.productImage.image = image
                          }, completion: nil)
    }
}
