//
//  RestrictionsViewController.swift
//  Marple
//
//  Created by Alex on 28/09/20.
//

import UIKit

class RestrictionsViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var ingredientsText: UITextView!
    
    let context = (UIApplication.shared.delegate as!
                    AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveBtnClick(_ sender: Any) {
        do{
            let newRestriction = Restriction(context: self.context)
            newRestriction.name = nameText.text
            newRestriction.ingredients = ingredientsText.text
            newRestriction.available = true
        
        try self.context.save()
        }catch{
            print("Error at savng the restriction")
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
