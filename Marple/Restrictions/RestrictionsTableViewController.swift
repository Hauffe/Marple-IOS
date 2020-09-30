//
//  RestrictionsTableViewController.swift
//  Marple
//
//  Created by Alex on 28/09/20.
//

import UIKit

class RestrictionsTableViewController: UITableViewController{
    
    var restrictionsList:[Restriction]?
    
    private let reuseIdentifier = "cell"
    let context = (UIApplication.shared.delegate as!
                    AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func fetchData() -> Void {
        do{
            self.restrictionsList = try context.fetch(Restriction.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }catch{
            print(error)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restrictionsList?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let restriction = self.restrictionsList?[indexPath.row]
        if let c = cell as? RestrictionsTableViewCell{
            c.delegate = self
            c.setRestriction(restrictionNew: restriction!)
            c.label.text = restriction?.name
            c.ingredients.text = restriction?.ingredients
            c.isActiveSwitch.setOn(restriction?.available ?? false, animated: true)
        }

        return cell
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
            let restrictionDeleted = self.restrictionsList![indexPath.row]
            restrictionsList?.remove(at: indexPath.row)
            self.context.delete(restrictionDeleted)
            do{
                try self.context.save()
            }catch{print("error")}
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        fetchData()
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RestrictionsTableViewController: RestrictionCellDelegate{
    func switchChangedValue(restriction: Restriction, value: Bool) {
        restriction.available = value
        do{
            try self.context.save()
        }catch{
            print(error)
        }
    }
}
