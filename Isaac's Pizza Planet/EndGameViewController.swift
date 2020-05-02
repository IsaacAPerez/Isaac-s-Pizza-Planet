//
//  EndGameViewController.swift
//  Isaac's Pizza Planet
//
//  Created by Isaac Abel Perez on 4/19/20.
//  Copyright © 2020 Isaac Abel Perez. All rights reserved.
//

import UIKit

class EndGameViewController: UIViewController {

    @IBOutlet weak var score: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backHomePressed(_ sender: Any) {
        performSegue(withIdentifier: "backHome", sender: self)
    }
    
    @IBAction func restartPressed(_ sender: Any) {
        performSegue(withIdentifier: "restart", sender: self)
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
