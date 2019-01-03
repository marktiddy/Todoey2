//
//  ViewController.swift
//  Todoey
//
//  Created by Mark Tiddy on 02/01/2019.
//  Copyright © 2019 Mark Richard Tiddy. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController   {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
        
        let newItem1 = Item()
        newItem1.title = "Eggs"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Quorn Sausages"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Peanuts"
        itemArray.append(newItem3)
        
        
    }
    
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary condition
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    
    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New TodoeyItem", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once add item is pressed
           
            if textField.text != "" {
                let newItem = Item()
                newItem.title = textField.text!

                self.itemArray.append(newItem)

                //Save to user defaults
                self.defaults.set(self.itemArray, forKey: "TodoListArray")


                self.tableView.reloadData() } else {
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
    
    
    
    }



