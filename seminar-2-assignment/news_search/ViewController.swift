//
//  ViewController.swift
//  news_search
//
//  Created by grace kim  on 2022/09/27.
//

import UIKit

class ViewController: UIViewController {
   
    let api = LoadNewsAPI.shared.self
    private let defaults = UserDefaults.standard
    
    private let tableView = UITableView()
    private var divider1 = UILabel()
    private var sortingView = UIView()
    private let searchBar = UISearchBar()
    private let mostRecent = UIButton()
    private let mostRelevant = UIButton()
    private let alert = UILabel()
    private let enterButton = UIButton()
   
    init() {
        super.init(nibName: nil, bundle: nil)
        backgroundAttributes()
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.tableView.insetsContentViewsToSafeArea = false
        self.tableView.rowHeight = 150
        // Do any additional setup after loading the view.
    }
    
    private func backgroundAttributes(){
        self.view.backgroundColor = .white
        self.navigationItem.titleView?.isHidden = true
        self.navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func addSubviews(){
        self.view.addSubview(searchBar)
        self.view.addSubview(divider1)
        self.view.addSubview(sortingView)
        self.view.addSubview(tableView)
        configureSearchBar()
        configureSortingButtons()
        configureTableView()
    }
    
    private func configureSearchBar(){
        searchBar.searchTextField.backgroundColor  = .white
        //searchBar.searchTextField.addTarget(self, action: #selector(didTapSearch), for: .editingChanged)
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        searchBar.setImage(UIImage(named: "naver_logo_insets"), for: .search, state: .normal)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -48).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        let directionalMargins = NSDirectionalEdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3)
        searchBar.directionalLayoutMargins = directionalMargins
        searchBar.setShowsCancelButton(false, animated: false)
        searchBar.addSubview(enterButton)
        searchBar.searchTextField.clearButtonMode = .never
        enterButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        enterButton.setImageTintColor(UIColor.gray)
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        enterButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        enterButton.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor).isActive = true
        enterButton.trailingAnchor.constraint(equalTo: self.searchBar.trailingAnchor, constant: -5).isActive = true
        enterButton.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
        searchBar.clipsToBounds = true
        searchBar.layer.cornerRadius = 25
        searchBar.layer.borderColor = styles.naver_green.cgColor
        searchBar.layer.borderWidth = 1
    }
    
    @objc func didTapSearch(){
        print(self.searchBar.text ?? "nothing searched")
        //파라미터 초기화
        init_params()
        configureSortingButtons()
        if ((self.searchBar.text?.isEmpty) == nil){
            configureAlertView()
            alert.text = "잘못된 검색어입니다."
        }else{
            self.alert.removeFromSuperview()
        api.requestAPI(queryValue: self.searchBar.text ?? "", completionHandler: { Bool in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                if (self.tableView.numberOfSections == 0){
                    self.configureAlertView()
                }
    }
        })
    }
}
    
    func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [NSAttributedString.Key.font: font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        let colorAttribute : [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.systemRed]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        attributedString.addAttributes(colorAttribute, range: range)
        return attributedString
    }
    
    func configureAlertView(){
        self.view.addSubview(alert)
        alert.textColor = UIColor.black
        alert.font = UIFont.systemFont(ofSize: 18, weight: .light)
        alert.attributedText = attributedText(withString: "'\(String(describing: self.searchBar.text ?? ""))' 에 대한 뉴스 검색결과가 없습니다.", boldString: "'\(String(describing: self.searchBar.text ?? ""))'", font: UIFont.systemFont(ofSize: 18))

        //alert.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        alert.translatesAutoresizingMaskIntoConstraints = false
        alert.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        alert.topAnchor.constraint(equalTo: self.sortingView.bottomAnchor, constant: 24).isActive = true
        alert.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -24).isActive = true
        alert.lineBreakMode = .byCharWrapping
        alert.numberOfLines = 0
        alert.sizeToFit()
    }
                       
                    
    func init_params(){
        api.display = 20
        api.start = 1
        api.sort = "sim"
        
    }
    
    private func configureSortingButtons(){
        divider1.layer.borderWidth = 1.0
        divider1.layer.borderColor = UIColor(red: 0.886, green: 0.898, blue: 0.91, alpha: 1).cgColor
        divider1.layer.backgroundColor = UIColor(red: 0.914, green: 0.925, blue: 0.937, alpha: 1).cgColor
        divider1.translatesAutoresizingMaskIntoConstraints = false
        divider1.heightAnchor.constraint(equalToConstant: 10).isActive = true
        divider1.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        divider1.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 20).isActive = true
        divider1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        sortingView.addSubview(mostRecent)
        sortingView.addSubview(mostRelevant)
        
        sortingView.translatesAutoresizingMaskIntoConstraints = false
        sortingView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        sortingView.topAnchor.constraint(equalTo: self.divider1.bottomAnchor).isActive = true
        sortingView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        sortingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        sortingView.backgroundColor = UIColor(red: 244/255.0, green: 247/255.0, blue: 248/255.0, alpha: 1.0)
        
        //question: 이렇게 반복적인 코드를 효율적으로 짜는 법?
        mostRelevant.setTitle("관련도순", for: .normal)
        mostRelevant.isSelected = true
        mostRelevant.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        mostRelevant.titleLabel?.adjustsFontSizeToFitWidth = true
        mostRelevant.translatesAutoresizingMaskIntoConstraints = false
        mostRelevant.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        mostRelevant.centerYAnchor.constraint(equalTo: self.sortingView.centerYAnchor).isActive = true
        mostRelevant.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        mostRelevant.imageView?.translatesAutoresizingMaskIntoConstraints = false
        mostRelevant.imageView?.widthAnchor.constraint(equalToConstant: 8).isActive = true
        mostRelevant.imageView?.heightAnchor.constraint(equalToConstant: 8).isActive = true
        mostRelevant.imageView?.centerYAnchor.constraint(equalTo: mostRelevant.centerYAnchor).isActive = true
        mostRelevant.setImageTintColor(styles.naver_green)
        mostRelevant.setTitleColor(UIColor.black, for: .selected)
        mostRelevant.addTarget(self, action: #selector(didTapSort(_:)), for: .touchUpInside)
        
        mostRecent.setTitle("최신순", for: .normal)
        mostRecent.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        mostRecent.isSelected = false
        mostRecent.translatesAutoresizingMaskIntoConstraints = false
        mostRecent.leadingAnchor.constraint(equalTo: self.mostRelevant.trailingAnchor, constant: 15).isActive = true
        mostRecent.centerYAnchor.constraint(equalTo: self.sortingView.centerYAnchor).isActive = true
        mostRecent.imageView?.translatesAutoresizingMaskIntoConstraints = false
        mostRecent.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        mostRecent.imageView?.widthAnchor.constraint(equalToConstant: 8).isActive = true
        mostRecent.imageView?.heightAnchor.constraint(equalToConstant: 8).isActive = true
        mostRecent.imageView?.centerYAnchor.constraint(equalTo: mostRecent.centerYAnchor).isActive = true
        mostRecent.setImageTintColor(styles.subtitle_gray1)
        mostRecent.setTitleColor(styles.subtitle_gray1, for: .normal)
        mostRecent.addTarget(self, action: #selector(didTapSort(_:)), for: .touchUpInside)
    }
    
    @objc func didTapSort(_ sender: UIButton){
        switch(sender.titleLabel?.text){
        case "관련도순":
            print("sort by relevant")
            self.mostRecent.isSelected = false
            self.mostRelevant.isSelected = true
            mostRelevant.setImageTintColor(styles.naver_green)
            mostRelevant.setTitleColor(UIColor.black, for: .selected)
            mostRecent.setImageTintColor(styles.subtitle_gray1)
            mostRecent.setTitleColor(styles.subtitle_gray1, for: .normal)
            init_params()
            api.sort = "sim"
            api.requestAPI(queryValue: self.searchBar.text ?? "", completionHandler: { Bool in
                DispatchQueue.main.async {
                self.tableView.reloadData()
                }})
            break
        
        case "최신순":
            print("sort by recent")
            self.mostRecent.isSelected = true
            self.mostRelevant.isSelected = false
            mostRecent.setImageTintColor(styles.naver_green)
            mostRecent.setTitleColor(UIColor.black, for: .selected)
            mostRelevant.setImageTintColor(styles.subtitle_gray1)
            mostRelevant.setTitleColor(styles.subtitle_gray1, for: .normal)
            init_params()
            api.sort = "date"
            api.requestAPI(queryValue: self.searchBar.text ?? "", completionHandler: { Bool in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }})
            break
        default:
            break
        }
    }

    
//==============================table view==============================
    
    private func configureTableView(){
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.sortingView.bottomAnchor, constant: 6),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        self.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        guard let news = DataManager.shared.searchResult?.items[indexPath.section] else { return UITableViewCell() }
        cell.configureNews(news)
        cell.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DataManager.shared.searchResult?.items.count ?? self.api.display
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension UIButton{
    func setImageTintColor(_ color: UIColor) {
        let tintedImage = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.tintColor = color
    }
}

/*
extension ViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffset_y = scrollView.contentOffset.y
        let tableViewContentSize = self.tableView.contentSize.height
        let pagination_y = tableViewContentSize * 0.2
        
        if contentOffset_y > tableViewContentSize - pagination_y {
            //TODO: something...error 하지 말자 걍
            print("scrolled down!")
            self.api.display = self.api.display + 20
            api.requestAPI(queryValue: self.searchBar.text ?? "")
            self.tableView.reloadData()
        }
        
    }
}*/


