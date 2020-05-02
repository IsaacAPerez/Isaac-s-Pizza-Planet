//
//  StartViewController.swift
//  Isaac's Pizza Planet
//
//  Created by Isaac Abel Perez on 4/13/20.
//  Copyright © 2020 Isaac Abel Perez. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet var score: UILabel!
    public static var scoreINT = 0
    public static var highlabel : UILabel?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        MusicPlayer.shared.startBackgroundMusic()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func StartButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "GameSegue", sender: self)
        MusicPlayer.shared.stop()
        MusicPlayer.shared.tapSound()
        MusicPlayer.shared.gameSound()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let dest = segue.destination as? GameViewController {
            dest.start = self
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
