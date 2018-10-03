//
//  TableViewCell.swift
//  Finalproject_AM
//
//  Created by Alexander Truong McNulty on 6/12/18.
//  Copyright © 2018 Alexander Truong McNulty. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func yesVoting(_ sender: Any) {
        yesButton.backgroundColor = #colorLiteral(red: 0.8272227645, green: 0.9874776006, blue: 0.8262019753, alpha: 1);
        if noButton.backgroundColor == #colorLiteral(red: 0.965398953, green: 0.760121823, blue: 0.730805554, alpha: 1) {
            noButton.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.5112639127)
        }
        colorResetTimer()
    }
    @IBAction func noVoting(_ sender: Any) {
        noButton.backgroundColor = #colorLiteral(red: 0.965398953, green: 0.760121823, blue: 0.730805554, alpha: 1);
        if yesButton.backgroundColor == #colorLiteral(red: 0.8272227645, green: 0.9874776006, blue: 0.8262019753, alpha: 1) {
            yesButton.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.5112639127)
        }
        colorResetTimer()
    }
    func colorResetTimer(){
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
            self.noButton.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.5112639127);
            self.yesButton.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.5112639127);
        }
    }
    

}
