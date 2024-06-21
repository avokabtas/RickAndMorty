//
//  ScrollToTop.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 16.06.2024.
//

import Foundation
import UIKit

extension UIViewController {
    private struct AssociatedKeys {
        static var tableViewKey: UInt8 = 0
    }
    
    func setupScrollToTopButton(for tableView: UITableView) {
        let scrollUpButton = UIBarButtonItem(image: Icon.up, style: .plain, target: self, action: #selector(scrollToTop))
        objc_setAssociatedObject(self, &AssociatedKeys.tableViewKey, tableView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        navigationItem.rightBarButtonItem = scrollUpButton
    }
    
    @objc private func scrollToTop() {
        guard let tableView = objc_getAssociatedObject(self, &AssociatedKeys.tableViewKey) as? UITableView else {
            return
        }
        
        let topOffset = CGPoint(x: 0, y: -tableView.adjustedContentInset.top)
        tableView.setContentOffset(topOffset, animated: true)
    }
}
