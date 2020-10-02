//
//  ProductTableViewController.swift
//  Marple
//
//  Created by Alex on 29/09/20.
//

import UIKit

class ProductTableViewController: UITableViewController {
    
    var productsList:[Product]?
    var restrictionsList:[Restriction]?
    
    private let reuseIdentifier = "cell"
    let context = (UIApplication.shared.delegate as!
                    AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func fetchData() -> Void {
        do{
            self.productsList = try context.fetch(Product.fetchRequest())
            self.restrictionsList = try context.fetch(Restriction.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }catch{
            print(error)
        }
    }

    // MARK: - Table view data source
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productsList?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let product = self.productsList?[indexPath.row]
        if let c = cell as? ProductViewCell{
            c.nameLabel.text = product?.name
            c.descLabel.text = product?.desc
            c.backgroundColor = checkProduct(product: product!) ? .green : .red
        }

        return cell
    }
    
    func checkProduct(product: Product) -> Bool{
        var appendedIngredients = ""
        var flag = true
        if (restrictionsList?.isEmpty == false)
        {
            restrictionsList?.forEach{restrictionValue in
                if(restrictionValue.available == true){
                    appendedIngredients.append(restrictionValue.ingredients ?? "")
                }
            }
        }
        let restrictionIngredients = appendedIngredients.components(separatedBy: ", ")
        let prodIngredients = product.ingredients?.components(separatedBy: ", ")
        
        for restrict in restrictionIngredients {
            if (prodIngredients?.contains(restrict) == true){
                flag = false
                break
            }else{
                flag = true
            }
        }
        return flag
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
            let productDeleted = self.productsList![indexPath.row]
            productsList?.remove(at: indexPath.row)
            self.context.delete(productDeleted)
            do{
                try self.context.save()
            }catch{print("error")}
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

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
