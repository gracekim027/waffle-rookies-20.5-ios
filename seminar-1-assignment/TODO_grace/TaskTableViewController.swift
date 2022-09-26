//
//  TaskTableViewController.swift
//  TODO_grace
//
//  Created by grace kim  on 2022/09/14.
//

import UIKit

struct template{
    static let backgroundYellow : UIColor = UIColor(red: 254/255.0, green: 249/255.0, blue: 236/255.0, alpha: 1.0)
    static let accentGreen : UIColor = UIColor(red: 49/255.0, green: 108/255.0, blue: 116/255.0, alpha: 1.0)
    
    static let firstBackground : UIColor = UIColor(red: 251/255.0, green: 229/255.0, blue: 202/255.0, alpha: 1.0) //orange
    static let secondBackground : UIColor = UIColor(red: 217/255.0, green: 228/255.0, blue: 251/255.0, alpha: 1.0) //blue
    static let thirdBackground : UIColor = UIColor(red: 219/255.0, green: 230/255.0, blue: 222/225.0, alpha: 1.0)
        //green
    static let fourthBackground : UIColor = UIColor(red: 248/255.0, green: 214/255.0, blue: 217/255.0, alpha: 1.0)
        //red
}


class TaskTableViewController: UIViewController {
    
    private let defaults = UserDefaults.standard
    
    private let ViewModel : ViewModel
    private let tableView = UITableView()
    var titleLabel = UILabel()
    var addButton = UIButton()
    var subtitleLabel = UILabel()
    var subtitleImageView = UIImageView()
    var lineImage = UIImageView()
    
    init(ViewModel : ViewModel) {
        self.ViewModel = ViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTaskList()
        self.tableView.reloadData()
        setNavBar()
        //count is 3 but max section is 2...
        view.addSubview(subtitleImageView)
        view.addSubview(lineImage)
        setSubtitleView()
        self.configureTableView()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 90
        
        //cell sends tapped edit noti --> shows edit VC --> gets edit completed noti
        NotificationCenter.default.addObserver(forName: Notification.Name("didTapEdit"), object: nil, queue: nil, using: didTapEdit)
        NotificationCenter.default.addObserver(forName: Notification.Name("isChecked"), object: nil, queue: nil, using: didTapCheck)
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
   
    }
    
    @objc func didTapCheck(_ notification: Notification) -> Void{
        guard let taskToEdit = notification.userInfo!["taskToEdit"] as? task else {
            return
        }
        ViewModel.checkTask(task_to_check: taskToEdit)
        //self.tableView.reloadData()
    }
    
    @objc func appMovedToBackground() {
        print("App moved to background!")
        //when moved to background --> save the user tasks in user default
        //question: saving 을 정확히 언제 언제 해야...?
        ViewModel.saveTaskList()
    }
    
    @objc func didTapEdit(_ notification: Notification) -> Void {
        guard let tasktoEdit = notification.userInfo!["task"] as? task else {
            return
        }
        let popupVC = EditTaskViewController(self_task: tasktoEdit)
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        present(popupVC, animated: true, completion: nil)
        
        //for when cell editing is done
        NotificationCenter.default.addObserver(forName: Notification.Name("didEditTask"), object: nil, queue: nil, using: didEditTask)
    }
    
    @objc func didEditTask(_ notification: Notification){
        guard let sectionNum = notification.userInfo!["task_sectionNum"]  else{
            return
        }
        guard let newTitle = notification.userInfo!["new_title"] else{
            return
        }
        let newDetails = notification.userInfo!["new_details"] ?? ""
        
        ViewModel.editTask(sectionNum: sectionNum as! Int, newTitle: newTitle as! String, newDetails: newDetails as! String)
        self.tableView.reloadData()
    }
    
    func setNavBar(){
        self.view.backgroundColor = template.backgroundYellow
        
        addButton.setTitle("add task", for: .normal)
        addButton.backgroundColor = template.accentGreen
        addButton.setTitleColor(.white, for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.clipsToBounds = true
        addButton.layer.cornerRadius = 15
        addButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addButton.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: addButton)
    
        self.navigationItem.rightBarButtonItem = item1
        let logo = UIImage(named: "TODO_-1")
        let logoImageView = UIImageView(image: logo)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.widthAnchor.constraint(equalToConstant: 156).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoImageView)
    }
    
    @objc func didTapAdd(){
        let popupVC = AddTaskViewController(numSection: ViewModel.taskList.count)
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        present(popupVC, animated: true, completion: nil)
        NotificationCenter.default.addObserver(forName: Notification.Name("addedNewTask"), object: nil, queue: nil, using: didAdd)
    }
    
    func didAdd(_ notification: Notification) -> Void{
        guard let title = notification.userInfo!["task_title"]  else{
            return
        }
        let details = notification.userInfo!["task_details"] ?? ""
        ViewModel.addTask(title: title as! String, details: details as? String)
        self.tableView.reloadData()
    }
    
    
    func setSubtitleView(){
        let subTitle = UIImage(named: "add a task to your notebook!")
        subtitleImageView.image = subTitle
        subtitleImageView.translatesAutoresizingMaskIntoConstraints = false
        subtitleImageView.widthAnchor.constraint(equalToConstant: 216).isActive = true
        subtitleImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        subtitleImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        subtitleImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 95).isActive = true
        
        let lineDivider = UIImage(named: "Line")
        lineImage.image = lineDivider
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        lineImage.widthAnchor.constraint(equalToConstant: 337).isActive = true
        lineImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120).isActive = true
    
    }
    
    func configureTableView(){
        self.view.addSubview(tableView)
        //tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = template.backgroundYellow
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.lineImage.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -24)
        ])
    
        self.tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "TaskTableViewCell")
        self.tableView.register(lineHeader.self, forHeaderFooterViewReuseIdentifier: "lineHeaderView")
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    private func loadTaskList(){
        let userDefaults = UserDefaults.standard
        guard let task_save = userDefaults.object(forKey: "taskList") as? [[String: Any]] else {return}
        self.ViewModel.taskList = task_save.compactMap {
            guard let sectionIndex = $0["sectionIndex"] as? Int else { return nil }
            guard let title = $0["title"] as? String else { return nil }
            guard let details = $0["details"] as? String else { return nil }
            guard let isChecked = $0["isChecked"] as? Bool else { return nil }
            return task(sectionIndex: sectionIndex, title: title, details: details, isChecked: isChecked)
        }
    }
    
}

extension TaskTableViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ViewModel.taskList.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        //let task = ViewModel.taskList[indexPath.section][indexPath.row]
        let task = ViewModel.taskList[indexPath.section]
        cell.configureView(setTask: task)
        cell.layer.cornerRadius = 40
        cell.layer.borderColor = UIColor(red:0/255, green:0/255, blue:0/255, alpha: 1).cgColor
        cell.layer.borderWidth = 2
        cell.clipsToBounds = true
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                       "lineHeaderView") as! lineHeader
         return view
    }
    
    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { _, _, complete in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.ViewModel.taskList.remove(at: indexPath.section)
                self.tableView.deleteSections([indexPath.section], with: .fade)
                self.tableView.reloadData()
            }
            complete(true)
                    }
            deleteAction.backgroundColor = template.backgroundYellow
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            configuration.performsFirstActionWithFullSwipe = true
            return configuration
        
    }
}

class lineHeader : UITableViewHeaderFooterView {
    
    private let lineImage : UIImageView = {
        let imageView = UIImageView()
        let lineDivider = UIImage(named: "Line")
        imageView.image = lineDivider
        return imageView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: "lineHeaderView")
        contentView.addSubview(lineImage)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        lineImage.widthAnchor.constraint(equalToConstant: 337).isActive = true
        lineImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
}

class ViewModel {
    
    var taskList : [task] = [task(sectionIndex: 0, title: "hello world", details: "swipe left to delete!", isChecked: false)]
        
    func saveTaskList() {
        let task_save = self.taskList.map {
            [
                "sectionIndex": $0.sectionIndex,
                "title": $0.title,
                "details": $0.details ?? "",
                "isChecked": $0.isChecked
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(task_save, forKey: "taskList")
    }
    
    func addTask(title : String, details: String?){
        let taskCount : Int = taskList.count
        let new_task = task(sectionIndex: taskCount, title: title, details: details ?? "", isChecked: false)
        taskList.append(new_task)
        self.saveTaskList()
    }
    
    func deleteTask(task_to_delete : Int){
        taskList.remove(at: task_to_delete)
        self.saveTaskList()
    }
    
    func checkTask(task_to_check : task){
        self.taskList[task_to_check.sectionIndex] = task_to_check
        self.saveTaskList()
    }
    
    func editTask(sectionNum: Int, newTitle: String, newDetails: String){
        var task = taskList[sectionNum]
        task.title = newTitle
        task.details = newDetails
        print("title: \(task.title) / new title: \(newTitle) / is changed?: \(taskList[sectionNum].title = newTitle)")
        print("details: \(String(describing: task.details)) / new title: \(newDetails) / is changed?: \(taskList[sectionNum].details = newDetails)")
        self.saveTaskList()
    }
}
