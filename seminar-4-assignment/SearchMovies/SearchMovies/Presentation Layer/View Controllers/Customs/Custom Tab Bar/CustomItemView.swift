//
//  CustomItemView.swift
//  CustomTabBarExample
//
//  Created by Jędrzej Chołuj on 18/12/2021.
//
import UIKit
import SnapKit

final class CustomItemView: UIView {
    
    
    private let iconImageView = UIImageView()
    private let containerView = UIView()
    let index: Int
    
    var isSelected = false {
        didSet {
            animateItems()
        }
    }
    
    private let item: CustomTabItem
    
    init(with item: CustomTabItem, index: Int) {
        self.item = item
        self.index = index
        
        super.init(frame: .zero)
        
        setupHierarchy()
        setupLayout()
        setupProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(containerView)
        containerView.addSubviews(iconImageView)
    }
    
    private func setupLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.center.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints {
            $0.width.equalTo(20)
            $0.height.equalTo(18)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    private func setupProperties() {

        iconImageView.image = isSelected ? item.selectedIcon : item.icon
    }
    
    private func animateItems() {
        
        UIView.transition(with: iconImageView,
                          duration: 0.2,
                          options: .transitionCrossDissolve) { [unowned self] in
            
            self.iconImageView.image = self.isSelected ? self.item.selectedIcon : self.item.icon
        }
    }
}
