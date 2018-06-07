//
//  ChatRoomViewController.swift
//  RandomChat
//
//  Created by Lương Linh on 7/6/18.
//  Copyright © 2018 toantt. All rights reserved.
//

import UIKit

class ChatRoomViewController: UIViewController {

    @IBOutlet weak var sendBtn: UIButton!
   
//    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var inputText: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
     
    @IBAction func sendMsg(_ sender: UIButton) {
        let inputText = self.inputText.text!
        print(inputText)
        
    }
    
}
