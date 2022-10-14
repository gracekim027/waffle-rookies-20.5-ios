//
//  FavoritesViewController.swift
//  movies
//
//  Created by grace kim  on 2022/10/08.
//

import UIKit

class FavoritesViewController: UIViewController {
   
    private let item : CustomTabItem
    
    init(item: CustomTabItem) {
            self.item = item
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    override func viewDidLoad() {
        self.view.backgroundColor = Styles.backgroundBlue
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
