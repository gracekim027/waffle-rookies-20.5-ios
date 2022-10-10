//
//  NewsTableViewCell.swift
//  news_search
//
//  Created by grace kim  on 2022/09/27.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    var my_news: NewsCellData?
    
    override var reuseIdentifier: String? {
        return "NewsTableViewCell"
    }
    
    var titleLabel = UILabel()
    var detailLabel = UILabel()
    var publisherLabel = UILabel()
    var dateLabel = UILabel()
    var divider = UILabel()
    var lineImage = UILabel()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "NewsTableViewCell")
       
        self.contentView.addSubview(publisherLabel)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(divider)
        configureSublabels()
            
        self.contentView.addSubview(titleLabel)
        configureTitleLabel()
            
        self.contentView.addSubview(detailLabel)
        configureDetailLabel()
            
        self.contentView.addSubview(lineImage)
        configureLineView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureNews(_ news: NewsCellData){
        self.my_news = news
        //question: 이거는 첫번째꺼만 되는듯...어떻게 다 하게 하지..?
        let common = news.title.slice(from: "<b>", to: "</b>")
        let parsed = news.title
            .replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "")
        titleLabel.attributedText = attributedText(withString: parsed, boldString: common ?? "", font: UIFont.systemFont(ofSize: 16))
            
        let common1 = news.itemDescription.slice(from: "<b>", to: "</b>")
        let parsed1 = news.itemDescription
            .replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "")
        detailLabel.attributedText = attributedText(withString: parsed1, boldString: common1 ?? "", font: UIFont.systemFont(ofSize: 15))
        
        //TODO: fix index out of range
        let text = news.originallink.components(separatedBy: "/")[2]
            .replacingOccurrences(of: "www.", with: "")
            .replacingOccurrences(of: ".com", with: "")
            .replacingOccurrences(of: ".co", with: "")
            .replacingOccurrences(of: ".kr", with: "")
            .replacingOccurrences(of: ".net", with: "")
        publisherLabel.text = text
        
        var datetime: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            let contentDate = news.pubDate
            return dateFormatter.string(from: contentDate)
        }
        dateLabel.text = datetime
    }

    
    func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [NSAttributedString.Key.font: font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }

    func configureSublabels(){
        publisherLabel.font =  UIFont.systemFont(ofSize: 13, weight: .regular)
        publisherLabel.textColor = styles.subtitle_gray1
        publisherLabel.translatesAutoresizingMaskIntoConstraints = false
        publisherLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24).isActive =  true
        publisherLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12).isActive = true
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.leadingAnchor.constraint(equalTo: self.publisherLabel.trailingAnchor, constant: 6).isActive = true
        divider.topAnchor.constraint(equalTo: self.publisherLabel.topAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 15).isActive = true
        divider.widthAnchor.constraint(equalToConstant: 1).isActive = true
        divider.backgroundColor = styles.subtitle_gray2
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leadingAnchor.constraint(equalTo: self.divider.trailingAnchor, constant: 6).isActive = true
        dateLabel.topAnchor.constraint(equalTo: self.publisherLabel.topAnchor).isActive = true
        dateLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        dateLabel.textColor = styles.subtitle_gray1
    }
    
    func configureTitleLabel(){
        titleLabel.textColor = styles.title_blue
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.publisherLabel.bottomAnchor, constant: 6).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24).isActive = true
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byCharWrapping
        titleLabel.sizeToFit()
    }
    
    func configureDetailLabel(){
        detailLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        detailLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24).isActive = true
        detailLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 6).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -24).isActive = true
        detailLabel.numberOfLines = 0
        detailLabel.lineBreakMode = .byCharWrapping
        detailLabel.sizeToFit()
    }
    
    func configureLineView(){
        lineImage.backgroundColor = UIColor(red: 0.914, green: 0.925, blue: 0.937, alpha: 1)
        lineImage.layer.borderColor = UIColor(red: 0.886, green: 0.898, blue: 0.91, alpha: 1).cgColor
        lineImage.layer.borderWidth = 0.5
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        lineImage.heightAnchor.constraint(equalToConstant: 10).isActive = true
        lineImage.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        lineImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        
    }
}

extension String {
    func slice(from: String, to: String) -> String? {
        guard let rangeFrom = range(of: from)?.upperBound else { return nil }
        guard let rangeTo = self[rangeFrom...].range(of: to)?.lowerBound else { return nil }
        return String(self[rangeFrom..<rangeTo])
    }
}

