//
//  RestrictionsTableViewCell.swift
//  Marple
//
//  Created by Alex on 28/09/20.
//

import UIKit

protocol RestrictionCellDelegate {
    func switchChangedValue(restriction: Restriction, value: Bool)
}

class RestrictionsTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var isActiveSwitch: UISwitch!
    
    var restrictionItem: Restriction!
    var delegate: RestrictionCellDelegate?
    
    func setRestriction(restrictionNew: Restriction){
        restrictionItem = restrictionNew
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func switchChanged(_ sender: UISwitch) {
        delegate?.switchChangedValue(restriction: restrictionItem, value: sender.isOn)
    }
}
