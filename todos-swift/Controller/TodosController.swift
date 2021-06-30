//
//  TodosController.swift
//  todos-swift
//
//  Created by 荣天阳 on 2021/6/30.
//

import UIKit

class TodosController: UITableViewController {
	
	var todos = [
		Todo(name: "吃饭", checked: true),
		Todo(name: "睡觉", checked: false),
		Todo(name: "写代码", checked: true),
		Todo(name: "带娃", checked: false)
	]
	var row = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		navigationItem.leftBarButtonItem = editButtonItem
		editButtonItem.title = "编辑"
	}
	
	//批量删除
	@IBAction func batchDelete(_ sender: Any) {
		if let selected = tableView.indexPathsForSelectedRows {
			// 修改model
			for indexPath in selected {
				todos.remove(at: indexPath.row)
			}
			// 更新view
			tableView.beginUpdates()
			tableView.deleteRows(at: selected, with: .automatic)
			tableView.endUpdates()
//			tableView.reloadData()
		}
	}
	
	override func setEditing(_ editing: Bool, animated: Bool) {
		super.setEditing(editing, animated: animated)
		editButtonItem.title = isEditing ? "完成" : "编辑"
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return todos.count
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath) as! TodoCell
		
		// Configure the cell...
		cell.checkMark.text = todos[indexPath.row].checked ? "√" : ""
		cell.todo.text = todos[indexPath.row].name
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if !isEditing {
			//修改model
			todos[indexPath.row].checked = !todos[indexPath.row].checked
			//修改view
			let cell = tableView.cellForRow(at: indexPath) as! TodoCell
			cell.checkMark.text = todos[indexPath.row].checked ? "√" : ""
			tableView.deselectRow(at: indexPath, animated: true)
		}
	}
	
	
	/*
	// Override to support conditional editing of the table view.
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the specified item to be editable.
	return true
	}
	*/
	
	
	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			// Delete the row from the data source
			todos.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		} else if editingStyle == .insert {
			// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
		}
	}
	override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
		return "删除"
	}
	
	
	
	// Override to support rearranging the table view.
	override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
		//移动数据
//		var arr = [1,2,3,4]
//		arr.remove(at: 0)
//		arr.insert(1, at: 3)
		let todo = todos[fromIndexPath.row]
		todos.remove(at: fromIndexPath.row)
		todos.insert(todo, at: to.row)
		//更新视图
//		tableView.moveRow(at: fromIndexPath, to: to)
		tableView.reloadData()
	}
	
	
	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the item to be re-orderable.
	return true
	}
	*/
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the new view controller using segue.destination.
		// Pass the selected object to the new view controller.
		if segue.identifier == "addTodo" {
			let vc = segue.destination as! TodoController
			vc.delegate = self
		}else if segue.identifier == "editTodo" {
			let vc = segue.destination as! TodoController
			let todoCell = sender as! TodoCell
			row = tableView.indexPath(for: todoCell)!.row
			vc.name = todos[row].name
			vc.delegate = self
		}
	}
	
}

extension TodosController: TodoDelegate {
	func didAdd(name: String) {
		//先改数据model
		todos.append(Todo(name: name, checked: false))
		//更新视图view
		let indexPath = IndexPath(row: todos.count - 1, section: 0)
		tableView.insertRows(at: [indexPath], with: .automatic)
	}
	func didEdit(name: String) {
		//先改数据model
		todos[row].name = name
		//更新视图view
		let indexPath = IndexPath(row: row, section: 0)
		let cell = tableView.cellForRow(at: indexPath) as! TodoCell
		cell.todo.text = name
	}
}
