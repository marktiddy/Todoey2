//
//  ViewController.swift
//  Todoey
//
//  Created by Mark Tiddy on 02/01/2019.
//  Copyright © 2019 Mark Richard Tiddy. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController    {
    
    var todoItems : Results<Item>?
    let realm = try! Realm()
    
    //Grabbing data from other VC
    var selectedCategory : Category? {
        didSet{
          loadItems()
        }
    }
    
    
    //End
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
         print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
   
        
        
    }
    
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
        
        cell.textLabel?.text = item.title
        
        //Ternary condition
        
        cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        
        return cell
    }
    
    
    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems? [indexPath.row] {
            do {
            try realm.write {
                item.done = !item.done
               // realm.delete(item)
                }
                
            } catch{
                print("error saving done status, \(error)")
            }
        }
        tableView.reloadData()
        
                tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New TodoeyItem", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
           // What will happen once add item is pressed
           
            
            if textField.text != "" {

                if let currentCategory = self.selectedCategory {
                    
                    do {
                    try self.realm.write {
                        
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                        }
                        
                    } catch {
                            print("Error saving new items /(error)")
                    }
                }
                
               //newItem.parentCategory = self.selectedCategory

                
                
                self.tableView.reloadData()

            

            } else {
                print("No data to add")
            }
            
           
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
          
        }
        
        alert.addAction(action)
        
        print("Success")
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK - Data manulupation models

    
    func loadItems() {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
    tableView.reloadData()
    }



}


//MARK - Search bar delegate methods

extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("I was clicked")
       
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
          //  tableView.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }

    }
}

    



